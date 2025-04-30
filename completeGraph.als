sig Node {
  edge: set Node,
  color: one Color,
}
abstract sig Color {}

fact isUndirected {
  all n1, n2: Node | n2 in n1.edge iff n1 in n2.edge
}

fact isCompleteGraph {
  //all g: Graph | not no g.S
  all disj n1, n2: Node | n2 in n1.edge
  all n: Node | n not in n.edge
}

fact isColored {
  all n1, n2:Node | n2 in n1.edge => n2.color != n1.color
}

assert correctNumberOfColors {
  #Node.color = #Node
}

//assert isColorable {
//  some g:Graph {
//	all n1:g.S | {
//		all n2: n1.edge | {
//			 n1 != n2 and n1.color != n2.color
// 		}
//	}
//  }  
//}

check correctNumberOfColors


