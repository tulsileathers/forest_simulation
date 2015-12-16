classdef W_Birch < Tree
    properties (Constant)
        G = 190.1; %Parameter that determines how early in its age (or size) a tree achieves most of its growth
        Dmax = 76;	%Maximum diameter at breast height (cm)
        Hmax = 3050;	%Maximum height (cm)
        AGEmax = 140;	%Maximum age (years)
        C = .486;	%Constant of proportionality relating leaf area to tree diameter
        ALmin = .99;	%Minimum proportion of incident sunlight needed for regeneration
        ALmax = 1.00; %Maximum proportion of incident sunlight needed for regeneration
        shadeTolerant = 0;
        shadeIntolerant = 1;
        shadeIntermediate = 0;
        b2	= 2 * (W_Birch.Hmax - 137)/W_Birch.Dmax;
        b3	= (W_Birch.Hmax - 137)/(W_Birch.Dmax^2);
    end
end