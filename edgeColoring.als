abstract sig Vertex {
  edges: set Vertex
}

abstract sig Color {}
one sig Red, Green extends Color {}

sig Edge {
  from, to: one Vertex,
  var color: one Color
}

fact UndirectedTree {
  // Undirected graph (edges are symmetric)
  edges = ~edges
  // Connected
  all n, m: Vertex | n != m => n in m.^edges
  // No self-loops
  no iden & edges
  // No cycles
  all n, m: Vertex | 
      let e = n->m + m->n | 
          e in edges => e not in ^(edges - e) 
}

fact {
  all n, m: Vertex | n->m in edges <=> one e: Edge | 
    (e.from = n and e.to = m) or (e.from = m and e.to = n)
  
  all e1, e2: Edge | 
    (e1.from = e2.to and e1.to = e2.from) => e1 = e2
}

fact EdgeColoringConstraints {
  all v: Vertex, e1, e2: Edge |
    (v in e1.from+e1.to and v in e2.from+e2.to and e1 != e2) =>
    e1.color != e2.color
}

run {} for exactly 5 Vertex, exactly 4 Edge

