function [ BAR ] = findTotalBasalArea(neighborTrees)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    BAR = 0;
    for i = 1:length(neighborTrees)
        BAR = BAR + (pi * neighborTrees(i).D^2)/4;
    end

end

