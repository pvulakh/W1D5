class KnightPathFinder
    attr_reader :considered_positions

    def self.valid_moves(pos)#checks what moves are ones I can get to (doing L shape) RETURNS ARRAY OF POSSIBLE POSITIONS
        idx1, idx2 = pos
        return false if idx1 > 8 || idx2 > 8
        return false if idx1 < 0 || idx2 < 0
        true 
        #8 two-element arrrays to fill out
        #check if they're going off the board
    end

    def [](pos)
        idx1, idx2 = pos
        #where is board??? is there board....
    end  

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree(@root_node)
    end

    def find_path(end_pos)
        
    end

    def build_move_tree

    end

    def new_move_positions(pos) #ALSO RETURNS ARRAY
        x, y = pos
        x += 2
        y += 1
        new_pos = [x, y]
        if KnightPathFinder.valid_moves(new_pos) && !self.considered_positions.include?(new_pos)
            self.considered_positions << new_pos
            return new_pos
        end
            x, y = pos
            x += 1
            y += 2
            new_pos = [x, y]
         if KnightPathFinder.valid_moves(new_pos) && !self.considered_positions.include?(new_pos)
            self.considered_positions << new_pos
            return new_pos
        end
    end
end