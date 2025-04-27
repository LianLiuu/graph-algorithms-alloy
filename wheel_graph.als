
// My wheel graph implementation:

sig Node{
	edges: set Node,
	color: one Color
}

one sig Hub extends Node{}

abstract sig Color{}

lone sig Red, Orange, Yellow, Green, Blue, Purple extends Color {}

pred isWheel{
	no (iden & edges)
	edges = ~edges
	all n1, n2: Node | n1 in n2.^edges
	all n: Node | {
		(n != Hub) => (#n.edges = 3)
		(n != Hub) => (Hub in n.edges)
	}
}

pred kColorable{
	all disj n1, n2: Node | (n2 in n1.edges) => (n1.color != n2.color)
}

run {isWheel and kColorable} for exactly 5 Node, exactly 3 Color

assert colorWheel {
	(isWheel) => (kColorable)
}

check colorWheel for exactly 5 Node, exactly 3 Color
