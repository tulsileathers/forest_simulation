classdef (Abstract) Tree
    properties (Abstract)
        %Tree species specific variables
        G	%Parameter that determines how early in its age (or size) a tree achieves most of its growth
        Dmax	%Maximum diameter at breast height (cm)
        Hmax	%Maximum height (cm)
        AGEmax	%Maximum age (years)
        C	%Constant of proportionality relating leaf area to tree diameter
        ALmin	%Minimum proportion of incident sunlight needed for regeneration
        ALmax	%Maximum proportion of incident sunlight needed for regeneration
    end
    properties
        %initial paremeters set to additive identity
        D = 0;%Diameter at breast height
        H = 0;%Height
        LA = 0; %Leaf area
        %constants
        b2	= 2 * (Hmax - 137)/Dmax;
        b3	= (Hmax - 137)/(Dmax^2);
    end
    methods
        
    end
end