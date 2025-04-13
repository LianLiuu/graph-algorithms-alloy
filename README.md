# graph-algorithms-alloy

## Description
We plan to model foundational graph algorithms in Alloy and use the models to verify their correctness. More specifically, we will be modeling the graph coloring problem (vertex coloring and edge coloring), the greedy algorithm of graph coloring, and hamiltonian path-finding. By using Alloy modeling, our project aims to find insights into graph properties and algorithm behaviors. We expect ourselves to learn more about these algorithms, and in a broader sense, graph theory, by finding how these algorithms work and their limitations. 

We chose to use Alloy for our project as Alloy works well with graph algorithms and graph concepts. Alloy’s visualizer has the ability to show each concept in a visual and easily understandable way. Alloy’s syntax is also well-suited to model graph concepts and find problems in graph algorithms, as we can use check and assert to find these problems. We will use Sterling, a web-visualizer for Alloy, to visualize our problems and approach.

## Foundation
For our foundational goals, we want to model the vertex coloring problem in Alloy, and the objective is to color each vertex in a graph such that no adjacent vertex shares the same color. We will use Alloy to impose constraints and enforce coloring rules, and use Sterling to visualize our model. The model will be able to check if a valid k-coloring exists for a graph. For smaller graphs, we will also use the model to explore chromatic number and instances of distinct colorings. Using check and assert, we will also use the model to prove different families of graphs (trees, cyclic, acyclic, etc) and if they are k-colorable. The model will help us understand why certain graphs are not k-colorable.

## Target
Our target goal will be to extend our vertex coloring model and create a model of the edge coloring problem in Alloy. We will show whether or not a given graph can be colored such that no two adjacent edges have the same color. This problem has similarities to the vertex coloring problem, which is why we chose it as a target goal. It builds off of the results we will find in our foundational model, but is a separate algorithm that we would also like to explore. We will prove important graph coloring properties, such as the chromatic index of a graph is either Δ or Δ+1 (Δ is max degree of a graph).

We will also model the greedy algorithm for the vertex coloring problem using Alloy. By modeling time and process, Alloy models how the algorithm picks and colors nodes, and we will observe how the coloring evolves. We will verify correctness at different steps of the model to check if the algorithm works as expected. The model can also help answer questions such as: How does visiting order affect the algorithm’s outcome?

##Reach
As a reach goal, we will attempt to use Alloy to find a Hamiltonian cycle for a given graph. These are cycles which go through every vertex of a graph only once. Through our implementation we will learn more about what types of graphs contain these cycles, which do not, and what characteristics cause a graph to contain a Hamiltonian cycle. 
