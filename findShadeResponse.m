function [ shadeResponse ] = findShadeResponse(tree,AL)
%Checks how intolerant a tree is of shade and calculates shade
%response accordingly
    if tree.shadeIntolerant || tree.shadeIntermediate
        shadeResponse = 2.24 * (1 - exp(-1.136 * (AL - 0.08)));
    else
        shadeResponse = 1 - exp(-4.64 * (AL - 0.05));
    end
end

