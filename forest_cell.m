classdef forest_cell
    %obj representing a cell in the simulation
    
    properties
        %keep track of whether or not each top of tree is alive
        hasTree = [0 0 0];
        %array of trees
        trees = [W_Birch Y_Birch Beech];
    end
    
    methods
        function [ presentTrees ] = findTrees(obj)
        %Finds those trees which a cell currently has alive
        presentTrees = [];
                for i = 1:length(obj.trees)
                    if obj.hasTree(i)
                        presentTrees = [presentTrees, obj.trees(i)];
                    end
                end
        end
    end
end

