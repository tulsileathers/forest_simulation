classdef forest_cell
    %obj representing a cell in the simulation
    
    properties
        hasTree = [0 0 0];
        trees = [W_Birch Y_Birch Beech];
    end
    
    methods
        function [ presentTrees ] = findTrees(obj)
        %Finds those trees which a cell currently has
        %   Detailed explanation goes here
        presentTrees = [];
                for i = 1:length(obj.trees)
                    if obj.hasTree(i)
                        presentTrees = [presentTrees, obj.trees(i)];
                    end
                end
        end
    end
end

