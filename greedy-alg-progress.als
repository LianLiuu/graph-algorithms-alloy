
sig Node{
	edges: set Node,
	var color: lone Color,
}

abstract sig Color{}

lone sig Red, Orange, Yellow, Green, Blue, Purple extends Color {}


pred init {
	no Node.color
}


------transition predicates ---------

pred color_a_node(n: Node){
	no n.color
	some n.color'
	(some n.edges.color) => (n.color' not in n.edges.color)
	--all nodes: n.edges | (some nodes.color) => (n.color' != nodes.color)
	all m: (Node - n) |m.color' = m.color
}

pred doNothing(n: Node){
	n.color = n.color'
}

---valid traces fact---

fact validTraces{
	init
	always {
		all n: Node | color_a_node[n] or doNothing[n]
	}
	eventually all nodes: Node |some nodes.color
	--eventually some n: Node | all c: Color | n.color = c
}

fact noSelfLoops{
	no (iden & edges)
}

run {} for exactly 5 Node
