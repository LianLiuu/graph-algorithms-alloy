abstract sig Bool {}
one sig False, True extends Bool {}

abstract sig Step {}
one sig Init, addNode, Fail, Done extends Step {}

sig Node {
  edge: set Node,
} 

one sig Cycle {
  var visited: set Node,
  var current: lone Node,
  var step: Step
}

pred init {
  all n: Node | n not in n.edge
  one n1:Node | {
	Cycle.visited = {n1}
	Cycle.current = n1
	Cycle.step = Init
  }
}

fact validTraces {
  init
  always {
     (one c: Cycle | 
        visitNode[c] or 
        markDone[c] or
        markFail[c] )
  }
}

fact findsHamiltonianPathIfExists {
  eventually (Cycle.step = Done or Cycle.step = Fail)
}

---- Transition predicates ----

pred visitNode[c:Cycle] {
  some n: Node - c.visited | { 
	c.current in n.edge 
  	c.visited' = c.visited + n
	c.current' = n
	c.step' = addNode
  }
}

pred markDone[c:Cycle] {
  #c.visited = #Node
  c.step' = Done
  c.visited' = c.visited
  c.current' = c.current
}

pred markFail[c:Cycle] {
  no n: Node - c.visited |
    c.current in n.edge 
  #c.visited < #Node
  c.step' = Fail
  c.visited' = c.visited
  c.current' = c.current
}


run {} for exactly 5 Node
