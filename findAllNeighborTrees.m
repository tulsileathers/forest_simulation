function [ trees ] = findAllNeighborTrees(neighbors)
%Returns all present trees in a list of neighbors
%inputs: neighbors - array of neighbors
%returns: the trees alive in each neighbor
    trees = [];
    for i = 1:length(neighbors)
        trees = [trees, findTrees(neighbors(i))];
    end
end

