sig Node {
  edges: set Node
}

fact BipartiteGraph {
  // Bipartite model with partitioning with sets
  edges = ~edges
  no iden & edges
  all v1, v2: Node | v1 in v2.^edges 
  some disj left, right: set Node {
    Node = left + right
    no left.edges & left  
    no right.edges & right  
  }
}

run {} for exactly 5 Node
