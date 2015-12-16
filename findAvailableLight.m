function [ AL ] = findAvailableLight(tree,neighbors, AL0,k)
%Finds the available light for a tree
%	inputs: tree - the tree in consideration
           %neighbors - the tree's neighbors
           %AL0 - the light incident above canopy
           %k - the light extinction coeficient
   %returns: the Available Light for the tree
   %shading leaf area index
   SLAI = 0;
   %calculate SLAI = sum of leaf areas of all trees greater than tree
   %considered over the neighborhood size
   for i = 1:length(neighbors)
       %for each neighbor
       neighbor = neighbors(i);
       neighborTrees = findTrees(neighbor); %find trees within each neighbor
       for n = 1:length(neighborTrees)
           if neighborTrees(n).LA > tree.LA %compare leaf areas
            SLAI = SLAI + neighborTrees(n).LA;
           end
       end
   end
   
   SLAI = SLAI/length(neighbors);%divide by neighborhood size
   %calculate Al
   %if neighborhood has no tree slai = 0 e^0 = 1
   AL = AL0 * exp( -(k * SLAI));
end
