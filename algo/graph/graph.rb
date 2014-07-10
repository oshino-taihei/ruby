class Node
  attr_reader :id
  def initialize(id)
    @id = id
  end

  def to_s
    return self.id.to_s
  end
end

class Edge
  attr_reader :fnode, :tnode
  def initialize(fnode, tnode)
    @fnode = fnode
    @tnode = tnode
  end

  def to_s
    return "[#{fnode},#{tnode}]"
  end
end

class Graph
  attr_reader :nodes, :edges
  def initialize()
    @nodes = []
    @edges = []
  end

  def has_node?(node)
    @nodes.each { |n|
      return true if n.id == node.id
    }
    return false
  end

  def has_edge?(edge)
    @edges.each { |e|
      return true if e.fnode == edge.fnode and e.tnode == edge.tnode
    }
    return false
  end

  def add_node(node)
    return if self.has_node?(node)
    @nodes.push(node)
  end
  
  def add_edge(edge)
    raise "Not exist node error." unless self.has_node?(edge.fnode) or self.has_node?(edge.tnode)
    return if self.has_edge?(edge)
    @edges.push(edge)
  end
  
  def to_s
    return "nodes=#{self.nodes},edges=[#{self.edges}]"
  end 
end

