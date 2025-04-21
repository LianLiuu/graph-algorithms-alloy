open util/graph[Node]

sig Node {
  edge: set Node,
  color: one Color,
}

abstract sig Color {}

one sig r, g, b extends Color {}

fact isUndirected {
  all n1, n2: Node | n2 in n1.edge iff n1 in n2.edge
}

fact isCompleteGraph {
  all disj n1, n2: Node | n2 in n1.edge
  all n: Node | n not in n.edge
}

fact isColorable {
   all disj n1, n2: Node | n2 in n1.edge => n1.color != n2.color
}

run { } for exactly 4 Node

