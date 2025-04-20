abstract sig Vertex {
  var color: one Color,
  edges: set Vertex
}

abstract sig Color {}
one sig Red, Green extends Color {}

//fact UndirectedTree {
//  -- 2 (configurations) trees can be colored for 3-4 Vertices
//  -- 5 trees can be colored for 5 Vertices
//  -- 16 trees can be colored for 6 Vertices
//  edges = ~edges
//  all n, m: Vertex| n != m => n in m.^edges
//  no iden & edges
//  all n, m: Vertex | 
//      let e = n->m + m->n | 
//          e in edges => e not in ^(edges - e) 
//}

fact planarGraph {
}

fact bipartiteGraph {
     all n: Vertex | one n.edges // one successor

    all n, m: Vertex | n in m.^edges // connected

    no iden & edges // no self loops
}


assert isKColorable {
  eventually all n, m: Vertex | n->m in edges => n.color != m.color
}

check isKColorable for 10 Vertex

//run {} for exactly 5 Vertex 
