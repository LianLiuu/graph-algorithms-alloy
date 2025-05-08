abstract sig Bool {}
one sig False, True extends Bool {}

abstract sig Step {}
one sig Init, addNode, Fail, Done extends Step {}

sig Node {
  edge: set Node,
} 

one sig Cycle {
  start: lone Node,
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
       Cycle.start = n1
  }
}

// comment out for directed graphs, works either way
fact isUndirected {
  all n1, n2: Node | n2 in n1.edge iff n1 in n2.edge
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

fact findsHamiltonianCycleIfExists {
  eventually (Cycle.step = Done or Cycle.step = Fail)
}

assert findsValidCycle {
  (Cycle.step = Done) => eventually {
	 Cycle.start in Cycle.current.edge // path is cycle
	#Cycle.visited = #Node // all node are visited once
  }
}

check findsValidCycle for exactly 5 Node

// generate valid cycle instances
pred onlyValidCycles {
  some c:Cycle | eventually c.step = Done
}

run onlyValidCycles for exactly 5 Node


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
  Cycle.start in Cycle.current.edge
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

