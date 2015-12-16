function [ trees ] = findAllNeighborTrees(neighbors)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    trees = [];
    for i = 1:length(neighbors)
        trees = [trees, findTrees(neighbors(i))];
    end
end

