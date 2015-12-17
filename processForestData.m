function [ W_B_BAR,Y_B_BAR,B_Bar,hasTreeGridList ] = processForestData( extGridList, m, n, centerDistance )
%Function to extract data from the simulation results
%inputs: extGridList -list of grid states
        %m, n - grid dimensions
        %centerDistance - boundary distance
        numIterations = length(extGridList);
        
        %Arrays of each tree type
        W_B_trees = cell(1, numIterations);
        Y_B_trees = cell(1, numIterations);
        B_trees = cell(1, numIterations);
        %Arrays of total Basal areas for each tree type at each timestep
        W_B_BAR = zeros(1,numIterations);
        Y_B_BAR = zeros(1,numIterations);
        B_Bar = zeros(1,numIterations);
        %indices of tree type within cell structure
        W_B_index = 1;
        Y_B_index = 2;
        B_index = 3;
        %grid of present trees at each time step
        hasTreeGrid = cell(m, n);
        hasTreeGridList = cell(1, numIterations);
        
    for i = 1:numIterations
        extGrid = extGridList{i};
        %find all the trees for each iteration
        for x = 1:m
            for y = 1:n
                forest_cell = extGrid(x + centerDistance, y + centerDistance);
                hasTree = forest_cell.hasTree;
                hasTreeGrid{x,y} = hasTree;%set tree presence
                trees = forest_cell.trees;
                %if tree type present add to respective list
                if(hasTree(W_B_index))
                    W_B_trees{i} = [W_B_trees{i}, trees(W_B_index)];
                end
                if(hasTree(Y_B_index))
                    Y_B_trees{i} = [Y_B_trees{i}, trees(Y_B_index)];
                end
                if(hasTree(B_index))
                    B_trees{i} = [B_trees{i}, trees(B_index)];
                end
            end
            display(i);
        end
        %find the basal areas
        W_B_BAR(i) = findTotalBasalArea(W_B_trees{i});
        Y_B_BAR(i) = findTotalBasalArea(Y_B_trees{i});
        B_Bar(i) = findTotalBasalArea(B_trees{i});
        hasTreeGridList{i} = hasTreeGrid;
    end

end

