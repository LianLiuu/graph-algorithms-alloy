sig Node {
  edges: set Node
}

fact planarGraph { 
  no iden & edges // No self loops
  edges = ~edges // is Undirected graph
  all v1, v2: Node | v1 in v2.^edges // connected
  
  // 3 conditions hold for planar graphs with 3 or more vertices
  let v = #Node, e = div[#edges, 2] | (v) >= 3 implies {
    // e ≤ 3v – 6
    (e) <= minus[mul[v, 3] , 6] 
    // f ≤ 2v – 4. f is for faces, euler formula
    let f = plus[minus[v, e], 2] | f <= minus[mul[v, 2], 4]
    // If there are no cycles of length 3, then e ≤ 2v – 4.
    noCycle3[] implies e <= minus[mul[v, 2], 4]
  }
}

pred noCycle3[] { // Helper, ensures no cycles of 3 
  no disj v1, v2, v3: Node | 
    v1->v2 in edges and v2->v3 in edges and v3->v1 in edges
}

run {} for exactly 4 Node, 5 Int
