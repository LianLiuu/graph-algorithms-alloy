open util/integer

abstract sig Vertex {
  var color: one Color,
  edges: set Vertex
}

abstract sig Color {}
one sig Red, Green extends Color {}

fact planarGraph {
  no iden & edges
  edges = ~edges
  all v1, v2: Vertex | v1 in v2.^edges
  
  (#Vertex).gt[3] implies (#edges).lte[(#Vertex).mul[3] - 6]
}


fact {
  all n, m: Vertex | n->m in edges => n.color != m.color
}


run {} for 4 Vertex 
