# forest_simulation

This is an implementation of Lett, Silber, and Barrett's cellular automata model of forest dynamics written in Matlab. Their original paper is available [here](http://www.sciencedirect.com/science/article/pii/S0304380099000903) (Paywall). This was a final project for a class in computational modeling which went well beyond the scope of the assignment. The model represents a forest as a grid of 2 meter square cells. Each cell may contain at most one of each of three types of trees(white birch, yellow birch, and beech) at a time. Each tree is described with specific variables which represent its physical attributes and its tolerance for light. At each time step the grid is updated according to rules equations governing the growth, death, and birth of tree individuals and taking into account competition for space and light with its neighbors. 

<p align="center">
<img src="https://github.com/jayce-leathers/forest_simulation/blob/master/images/tables1.png" alt="alt text" width="75%" >
<img src="https://github.com/jayce-leathers/forest_simulation/blob/master/images/tables2.png" alt="alt text" width="75%" >
</p>
