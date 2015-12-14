classdef Y_Birch < Tree
    properties
        G = 143.6; %Parameter that determines how early in its age (or size) a tree achieves most of its growth
        Dmax = 100;	%Maximum diameter at breast height (cm)
        Hmax = 3050;	%Maximum height (cm)
        AGEmax = 300;	%Maximum age (years)
        C = 0.486;	%Constant of proportionality relating leaf area to tree diameter
        ALmin = 0.90;	%Minimum proportion of incident sunlight needed for regeneration
        ALmax = 0.99; %Maximum proportion of incident sunlight needed for regeneration
    end
end