sig Node {
  edges: set Node,
  var color: lone Color,
}

abstract sig Color {}

fact isCompleteGraph {
  // no self loop
  all n: Node | n not in n.edges
  // undirected
  all n1, n2: Node | n2 in n1.edges iff n1 in n2.edges
  all disj n1, n2: Node | n2 in n1.edges
}


pred init {
  no Node.color  
}


fact validTraces {
  init
  always { 
    doNothing or
    some n: Node | color_node[n]
  }
}

pred doNothing {
  all n: Node | n.color' = n.color
}

pred color_node[n:Node] {
  no n.color 
  some c:Color | n.color'=c
  n.color' not in n.edges.color
}

pred eventuallyAll {
  eventually (all n: Node | some n.color) 
}

fact noSameColorNeighbors {
  always all n: Node | all m: n.edges | 
    some n.color and some m.color => n.color != m.color
}

run {eventuallyAll} for exactly 3 Node, exactly 10 Color

assert correctNumberOfColors {
  eventually #Node.color = #Node
}

run {eventuallyAll} for 20 Node, exactly 40 Color
