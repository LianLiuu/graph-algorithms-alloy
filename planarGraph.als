sig Node {
  edges: set Node,
  var color: lone Color
}

abstract sig Color {}
one sig Red, Orange, Yellow extends Color {}

pred init {
	no Node.color  
}

pred initialColoring[n: Node] {
	// Node is uncolored 
	no n.color       
    
	// Set Node's color
	n.color' = Red or n.color' = Orange or n.color' = Yellow

	// Leave other Nodes unmodified
	all m: Node - n | m.color' = m.color    
}

pred color_a_node[n: Node] { // colors a Node based on neighbors
	// Node is uncolored 
	no n.color 

	// Node's new color should not be the same as any neighbors
	(some n.edges.color => n.color' not in n.edges.color)

	// Any neighbors's color should not be the same as the Node's new color
	(no n.edges.color => (n.color' = Red or n.color' = Orange or n.color' = Yellow))

	// Leave other Nodes unmodified
 	all m: Node - n | m.color' = m.color    
}

pred doNothing {
	all n: Node | n.color' = n.color
}

fact validTraces {
	init
	always { 
	    doNothing or
	    (some n: Node | initialColoring[n]) or
           (some n: Node | color_a_node[n])
  	}
}

fact planarGraph { 
  no iden & edges // No self loops
  edges = ~edges // is Undirected graph
  all v1, v2: Node | v1 in v2.^edges // connected
  
  // 3 conditions hold for planar graphs with 3 or more vertices
  let v = #Node, e = #edges | (v) >= 3 implies {
    // e ≤ 3v – 6
    (e) <= minus[mul[v, 3] , 6] 
    // f ≤ 2v – 4. f is for faces
    let f = plus[minus[v, e], 2] | f <= minus[mul[v, 2], 4]
    // If there are no cycles of length 3, then e ≤ 2v – 4.
    noCycle3[] implies e <= minus[mul[v, 2], 4]
  }
}

pred noCycle3[] { // Helper, ensures no cycles of 3 
  no disj v1, v2, v3: Node | 
    v1->v2 in edges and v2->v3 in edges and v3->v1 in edges
}

fact kcolorable {
  always all n: Node | all m: n.edges | 
    (some n.color and some m.color) => n.color != m.color
}

pred eventuallyAll {
	eventually (all n: Node | some n.color) 
}

run {eventuallyAll} for exactly 8 Node
