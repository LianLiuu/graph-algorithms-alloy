sig Node {
  edges: set Node,
  var color: lone Color
}

abstract sig Color {}

lone sig Red, Orange, Yellow, Green, Blue, Purple extends Color {}

pred init {
  no Node.color
}

--------------**Transition Predicates**--------------

pred color_a_node(n: Node) {
  no n.color
  some n.color'
  (some n.edges.color) => (n.color' not in n.edges.color)
  all m: (Node - n) |m.color' = m.color
}

pred doNothing(n: Node) {
  n.color = n.color'
}

---------------**Valid Traces Fact**------------------

fact validTraces {
  init
  always {
    all n: Node | color_a_node[n] or doNothing[n]
  }
  eventually all nodes: Node |some nodes.color
  -- This makes it so we only have colors in a graph if they're being used
  eventually (all c: Color | some n: Node | n.color = c)
}

fact undirectedConnected {
  no (iden & edges) // no self loops
  edges = ~edges // undirected
  all v1, v2: Node | v1 in v2.^edges // connected
}

run {} for exactly 5 Node
