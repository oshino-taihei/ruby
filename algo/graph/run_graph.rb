require './graph'

# Create a graph

n1 = Node.new(1)
n2 = Node.new(2)
n3 = Node.new(3)
n4 = Node.new(4)
e1 = Edge.new(n1,n2)
e2 = Edge.new(n1,n3)
e3 = Edge.new(n2,n4)
e4 = Edge.new(n3,n4)
g = Graph.new
g.add_node(n1)
g.add_node(n2)
g.add_node(n3)
g.add_node(n4)
g.add_edge(e1)
g.add_edge(e2)
g.add_edge(e3)
g.add_edge(e4)

puts g
