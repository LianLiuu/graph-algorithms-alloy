
sig Node{
	edges: set Node,
	var color: one Color,
}

abstract sig Color{}

one sig Red, Orange, Yellow, Green, Blue, Purple, Uncolored extends Color {}


pred init {
	all n: Node | n.color = Uncolored
}


------transition predicates ---------

pred color_a_node(n: Node){
	n.color = Uncolored
	n.color' != Uncolored
	all nodes: n.edges | (nodes.color != Uncolored) => (n'.color != nodes.color)
}

pred doNothing(n: Node){
	n.color = n'.color
}

---valid traces fact---

fact validTraces{
	init
	always {
		all n: Node | color_a_node[n] or doNothing[n]
	}
	eventually all nodes: Node | nodes.color != Uncolored
}

fact noSelfLoops{
	no (iden & edges)
}

run {} for exactly 4 Node


