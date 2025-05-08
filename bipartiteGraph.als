sig Node {
  edges: set Node
}

fact BipartiteGraph {
  edges = ~edges
  no iden & edges
  all v1, v2: Node | v1 in v2.^edges 
  some disj left, right: set Node {
    Node = left + right
    all n: left, m: right | n->m in edges => m->n in edges
    no left.edges & left  
    no right.edges & right  
  }
}

run {} for exactly 5 Node
