sig Node {
  edges: set Node
}

abstract sig Color {}
one sig Red, Green extends Color {}

sig Edge {
  from, to: one Node,
  var color: one Color
}

fact undirectedConnected { 
  no iden & edges // No self loops
  edges = ~edges // is Undirected graph
  all v1, v2: Node | v1 in v2.^edges // connected
}

fact {
  all n, m: Node | n->m in edges <=> one e: Edge | 
    (e.from = n and e.to = m) or (e.from = m and e.to = n)
  
  all e1, e2: Edge | 
    (e1.from = e2.to and e1.to = e2.from) => e1 = e2
}

fact EdgeColoringConstraints {
  all v: Node, e1, e2: Edge |
    (v in e1.from+e1.to and v in e2.from+e2.to and e1 != e2) =>
    e1.color != e2.color
}

run {} for exactly 5 Node, exactly 4 Edge
