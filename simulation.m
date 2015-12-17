clear all
%model based on http://www.sciencedirect.com/science/article/pii/S0304380099000903

%CONSTANTS
%Simulation Constants
dt = 1; %timestep
simulationLength = 200; %simulation length
numIterations = simulationLength/dt; % number of iterations
m = 25; %size of forest in cells = m x n
n = 25;
R = 6; %neighborhood radius meters
s_cell = 2; %size of cell in meters
centerDistance = fix(R/s_cell); %max radial neighborhood distance

%Light Constants
AL0 = .99; %light incident above canopy
k = .56; %light extinction coefficient %http://link.springer.com/article/10.1007%2Fs11707-014-0446-7

%Space Constants
BARmax = 150; %maximum basal area unsure what this should be????

%Death Constants
ageDeathFraction = .001; %fraction of trees to reach species dependent maximum age
competitionDeathFraction = .01; %fraction of trees which should die if growth is below AINC
AINC = .001; %minimum D increment to not have a chance of death
competitiveDeathProbability = 1 - competitionDeathFraction^(1/10); %chance of competitive death


%VARIABLES
%initialize extended grid to default forest cells with all tree types dead
extGrid((m + 2 * centerDistance),(n + 2 * centerDistance)) = forest_cell;
% extended grid, including boundary  conditions
extGridList = cell(1,numIterations);
extGridList{1} = extGrid;
nextGrid = extGrid; %grid to hold changes during 

%FUNCTIONS
radialMask = zeros(2*centerDistance + 1, 2*centerDistance + 1); %mask used to find radial neighbors
%calculates a mask values 
for i = -centerDistance:centerDistance
    for j = -centerDistance:centerDistance
        %if cooridinate is within R of center
        screenx = i + fix((2*centerDistance + 1)/2) + 1;
        screeny = fix((2*centerDistance + 1)/2) - j + 1;
        if ~((screenx == centerDistance + 1) && (screeny == centerDistance + 1)) %cell is not in its own neighborhood
            if i^2 + j^2 <= R^2/s_cell^2
                %is one of the cell's neighbors
                radialMask(screenx, screeny) = 1;
            end
        end
    end
end 

% radial neighbor func
% input: x,y, coordinates of grid element
%        extGrid - current extended grid
% output: array of neighborhood elements within R of x,y
radialNeighbors = @(x, y, extGrid) (findRadialNeighbors(x, y, extGrid, R, s_cell,radialMask));

% optimal growth func
% input: tree - the tree to determine growth
% output: the tree's growth without limiting factors
optimalGrowth = @(tree) (((tree.G * tree.D) * ...
         (1 - (tree.D * tree.H)/(tree.Dmax * tree.Hmax)))...
         /(247 + 3 * tree.b2 * tree.D - 4 * tree.b3 * tree.D^2));
     
% available light func
% input: tree - the tree to determine available light for
        %neighborTrees - the trees within the tree's neighbor cells
% output: returns the available light
availableLight = @(tree, neighborTrees) (findAvailableLight(tree,neighborTrees, AL0,k));

% func to calc the average amount of an area occupied by tree stems.
    %It is defined as the total cross-sectional area of all stems in a stand measured at
    %breast height, and expressed as per unit of land area
    %measure of available space
% input: neighborTrees - the trees within the tree's neighbor cells
% output: the space available for the tree
totalBasalArea = @(neighborTrees) (findTotalBasalArea(neighborTrees));

%calculates shade response based on tolerance of tree
% input: tree - the tree
        %AL - availabe light of tree
% output: returns limiting growth factor due to shade
shadeResponse = @(tree, AL) (findShadeResponse(tree,AL));

%calculates space response based on tolerance of tree
% input: BAR - the available space for the tree
% output: returns limiting growth factor due to space
spaceResponse = @(BAR) (1 - BAR/BARmax); %

%calculates probility of a tree dying due to old age
% input: tree - the tree to try and kill
% output: the probability
deathDueToAgeProbability = @(tree) (log(ageDeathFraction)/tree.AGEmax);

%calculates probility of a tree dying due to old age
% input: tree - the tree to try and kill
        %changeInD - the amount the tree grew this iteration if < AINC chance to die
        %rand1, rand2, two random numbers b/t 0 and 1 
% output: boolean representing whether or not the tree dies
shouldKillTree = @(tree, changeInD,rand1,rand2) ((...
    rand1 < deathDueToAgeProbability(tree))...%death due to age
    || ((changeInD < AINC) && (rand2 < competitiveDeathProbability)));%death due to low growth  

%calculates whether or not a new tree grow
% input: tree - the type of tree to try and grow
        %AL - availabe light of tree
% output: boolean representing whether or not the tree is added
shouldAddTree = @(tree, AL) (tree.ALmin <= AL && AL <= tree.ALmax);

% simulation loop
for i=2:numIterations
    %loop through every cell
    nextGrid = extGridList{i - 1};
    extGrid = extGridList{i - 1};
    for x = 1:m
        for y = 1:n
            neighbors = radialNeighbors(x + centerDistance,y + centerDistance, extGrid);
            neighborTrees = findAllNeighborTrees(neighbors);
            forest_cell = extGrid(x + centerDistance, y + centerDistance);
            BAR = totalBasalArea(neighborTrees);%calc basal area
            space = spaceResponse(BAR);
            %for each tree type t that is not in forest(x,y) if
            %ALmini<=AL<=ALmaxi add tree t
            for t = 1:length(forest_cell.trees)
                tree = forest_cell.trees(t);
                AL = availableLight(tree, neighborTrees);
                if(forest_cell.hasTree(t))
                    %t is in cell
                    Dopt = optimalGrowth(tree);%calc opt diameter growth
                    %calc available light
                    %calc response to light & space availability as applicable
                    shade = shadeResponse(tree, AL);
                    %calc actual diameter growth
                    deltaD = Dopt * shade * space;
                    %check if tree dies due to chance
                    %check if tree dies due to competition
                    if shouldKillTree(tree, deltaD,rand,rand)
                        %killTree
                        tree.D = 0;
                        tree.H = 0;
                        tree.LA = 0;
                        tree.AGE = 0;
                        forest_cell.hasTree(t) = 0;
                    else
                        %update values of diameter height leaf area and age
                        tree.D = tree.D + deltaD;
                        tree.H = 137 + tree.b2 * tree.D - tree.b3 * tree.D^2;
                        tree.LA = tree.C * tree.D^2;
                        tree.AGE = tree.AGE + 1;
                    end
                else%t is not in cell
                    %try to add new tree of type t
                    if shouldAddTree(forest_cell.trees(t), AL)
                        tree.D = tree.D + 1; %assumed one cm first year growth
                        tree.H = 137 + tree.b2 * tree.D - tree.b3 * tree.D^2;
                        tree.LA = tree.C * tree.D^2;
                        tree.AGE = tree.AGE + 1;
                        forest_cell.hasTree(t) = 1;
%                         forest_cell.hasTree(t) = 1;
                    end%else t remains dead
                end
                forest_cell.trees(t) = tree;
            end
            nextGrid(x + centerDistance, y + centerDistance) = forest_cell;
        end
    end
    extGridList{i} = nextGrid;
    display(i)
end

save('simulation.mat', 'extGridList')