classdef (Abstract) Tree < handle & matlab.mixin.Heterogeneous
    properties (Abstract=true, Constant=true)
        %Tree species specific variables
        G;	%Parameter that determines how early in its age (or size) a tree achieves most of its growth
        Dmax;	%Maximum diameter at breast height (cm)
        Hmax;	%Maximum height (cm)
        AGEmax;	%Maximum age (years)
        C;	%Constant of proportionality relating leaf area to tree diameter
        ALmin;	%Minimum proportion of incident sunlight needed for regeneration
        ALmax;	%Maximum proportion of incident sunlight needed for regeneration
        %vulnerability to shade booleans
        shadeTolerant;
        shadeIntolerant;
        shadeIntermediate;
        b2;
        b3;
    end
    properties
        %initial paremeters set to additive identity
        D = 0;%Diameter at breast height
        H = 0;%Height
        LA = 0; %Leaf area
        AGE = 0; %age of tree
        BAR = 0; %Total basal area of neighborhood at current time
        %constants
    end
    methods
        
    end
end