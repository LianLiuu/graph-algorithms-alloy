open util/integer

abstract sig Vertex {
  var color: one Color,
  edges: set Vertex
}

abstract sig Color {}
one sig Red, Green extends Color {}

fact planarGraph { 
-- This is a simplified version of a planar graph model
-- it passes the Euler formula but accepts K3 and K5 graphs

  no iden & edges
  edges = ~edges
  all v1, v2: Vertex | v1 in v2.^edges
  
  (#Vertex) > 3 implies (#edges) <= minus[mul[#Vertex, 3] , 6]
}


fact {
  all n, m: Vertex | n->m in edges => n.color != m.color
}


run {} for 5 Vertex 
