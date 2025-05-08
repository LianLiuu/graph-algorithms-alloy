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

// comment out for directed graphs instances, works either way
fact isUndirected {
  no iden & edge // No self loops
  edge = ~edge // is Undirected graph
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

run onlyValidCycles for 10 Node


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

---- Properties Checking ----

fun deg[n: Node]: Int {
  #(n.edge)
}

fact meetOreConditions {
  #Node >= 3
  all disj u, v: Node | 
    not (v in u.edge) implies 
      add[deg[u], deg[v]] >= #Node
}

pred oreImpliesHamiltonian {
    eventually Cycle.step = Done
}

run oreImpliesHamiltonian for exactly 7 Node

pred noCycle3[] { // Helper, ensures no cycles of 3 
  no disj v1, v2, v3: Node | 
    v1->v2 in edge and v2->v3 in edge and v3->v1 in edge
}

pred is4Connected {
  all r1, r2, r3: Node |
    let remaining = Node - r1 - r2 - r3 |
      all a, b: remaining |
        b in a.^ (edge & (remaining -> remaining))
}

// a four connected Planar graph is always hamiltonian
pred is4ConnectedPlanar { 
 
    is4Connected[]
    no iden & edge // No self loops
    edge = ~edge // is Undirected graph
    all v1, v2: Node | v1 in v2.^edge // connected

    // 3 conditions hold for planar graphs with 3 or more vertices
    let v = #Node, e = div[#edge, 2] | (v) >= 3 implies {
      // e ≤ 3v – 6
      (e) <= minus[mul[v, 3] , 6] 
      // f ≤ 2v – 4. f is for faces, euler formula
      let f = plus[minus[v, e], 2] | f <= minus[mul[v, 2], 4]
      // If there are no cycles of length 3, then e ≤ 2v – 4.
      noCycle3[] implies e <= minus[mul[v, 2], 4]
    }
}

pred fourConnectedPlanarIsHamiltonian {
   is4ConnectedPlanar[] and eventually Cycle.step = Done
}

run fourConnectedPlanarIsHamiltonian for 5 Node



