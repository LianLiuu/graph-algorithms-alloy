abstract sig Node {
  var color: one Color,
  edges: set Node
}

abstract sig Color {}
one sig Red, Green extends Color {}

fact UndirectedTree {
  -- 2 (configurations) trees can be colored for 3-4 Nodes
  -- 5 trees can be colored for 5 Nodes
  -- 16 trees can be colored for 6 Nodes
  edges = ~edges
  all n, m: Node| n != m => n in m.^edges
  no iden & edges
  all n, m: Node | 
      let e = n->m + m->n | 
          e in edges => e not in ^(edges - e) 
}

fact {
  all n, m: Node | n->m in edges => n.color != m.color
}

run {} for exactly 5 Node
