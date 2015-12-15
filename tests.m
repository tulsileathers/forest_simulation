expected = {'1,4','2,2','2,3','2,4','2,5','2,6','3,2','3,3','3,4','3,5','3,6','4,1','4,2','4,3','4,4','4,5','4,6','4,7','5,2','5,3','5,4','5,5','5,6','6,2','6,3','6,4','6,5','6,6','7,4'};

R = 6; %neighborhood radius meters
s_cell = 2; %size cell in meters
centerDistance = fix(R/s_cell);
radialNeighbors = @(x, y, extGrid) (findRadialNeighbors(x, y, extGrid, R, s_cell));
extGrid = cell(m + centerDistance, n + centerDistance);

for i = 1:m+centerDistance
    for j = 1:n+centerDistance
        extGrid{i,j} = cellstr(strcat(num2str(i), strcat(',', num2str(j))));
    end
end
neighborTest = radialNeighbors(4,4, extGrid);