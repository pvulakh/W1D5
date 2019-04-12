require_relative '00_tree_node'

class KnightPathFinder
  attr_accessor :considered_positions, :root_node

  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]
  def self.valid_moves(pos)
    valid_moves = []

    MOVES.each do |move|
      new_pos = [pos[0] + move[0], pos[1] + move[1]]
      #debugger
      valid_moves << new_pos if new_pos.all? { |coord| 0 <= coord && coord < 8 }
    end 

    valid_moves
  end 

  def initialize(pos)
    @considered_positions = [pos]

    build_move_tree
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_moves = []

    valid_moves.each do |move| #reject seen positions
      new_moves << move unless self.considered_positions.include?(move)
    end 

    self.considered_positions.concat(new_moves) #make sure new_moves are registered as considered before returning them
    new_moves 
  end 

  def build_move_tree
    #this tree of moves is structured thusly: each node's next moves - new_move_positions(node) - are its children
    # where is the tree? the tree is stored in @root_node; it contains references to its children (and it's children's children; all of the possible moves)
    @root_node = PolyTreeNode.new(self.considered_positions[0]) 
    queue = [self.root_node]

    until queue.empty? #keep building tree until no more nodes (positions) to process
      current_node = queue.shift #on first iteration, will be root_node

      current_pos = current_node.value 
      self.new_move_positions(current_pos).each do |new_pos|
        new_node = PolyTreeNode.new(new_pos) #create node for each new_pos
        current_node.add_child(new_node) #link current_node and children
        queue << new_node #enqueue to process later
      end 
    end 
  end 

  def find_path(end_pos)
    end_node = self.root_node.dfs(end_pos)

    path_of_nodes = self.trace_path_back(end_node)
    path_of_nodes.reverse.map { |node| node.value }
  end 

  def trace_path_back(end_node)
    path_of_nodes = []

    current_node = end_node
    until current_node.nil? #until we are at the root node's parent (which is nil)
      path_of_nodes << current_node 
      current_node = current_node.parent #travel one level up the tree
    end 

    path_of_nodes #remember that this is backwards right now since we started at end_pos!
  end 
end 

