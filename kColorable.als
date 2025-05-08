sig Node {
  edges: set Node,
  color: one Color
}

abstract sig Color {}

sig Red, Orange, Yellow, Green, Blue, Purple extends Color {}

fact Connected {
  all n1, n2: Node | n2 in ^edges.n1
}

pred kColorable {
  // A graph is k-colorable when no two adjacent nodes share the same color.
  all disj n1, n2: Node | (n2 in n1.edges) => (n1.color != n2.color)
}

run {kColorable} for exactly 3 Node, exactly 2 Color

assert k {
  kColorable
}

check k for exactly 3 Node, exactly 3 Color
