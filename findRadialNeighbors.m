function [ neighbors ] = findRadialNeighbors( x, y, extgrid, R, s_cell)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    
    centerDistance = fix(R/s_cell);
    for i = -centerDistance:centerDistance
        for j = -centerDistance:centerDistancesideLength
            if i^2 + j^2 <= R^2/s_cell^2
                neighbors = [neigbors, extgrid(x + i, y + j)];
            end
        end
    end
        
        
end