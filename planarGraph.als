open util/integer

abstract sig Vertex {
  var color: one Color,
  edges: set Vertex
}

abstract sig Color {}
one sig Red, Green extends Color {}

fact planarGraph { 
  no iden & edges // No self loops
  edges = ~edges // is Undirected graph
  all v1, v2: Vertex | v1 in v2.^edges // no cycles
  
  // 3 conditions hold for planar graphs with 3 or more vertices
  let v = #Vertex, e = #edges | (v) >= 3 implies {
    // e ≤ 3v – 6
    (e) <= minus[mul[v, 3] , 6] 
    // f ≤ 2v – 4. f is for faces
    let f = plus[minus[v, e], 2] | f <= minus[mul[v, 2], 4]
    // If there are no cycles of length 3, then e ≤ 2v – 4.
    noCycle3[] implies e <= minus[mul[v, 2], 4]
  }
}

pred noCycle3[] { // Helper, ensures no cycles of 3 
  no disj v1, v2, v3: Vertex | 
    v1->v2 in edges and v2->v3 in edges and v3->v1 in edges
}


fact {
  all n, m: Vertex | n->m in edges => n.color != m.color
}


run {} for 8 Vertex 
