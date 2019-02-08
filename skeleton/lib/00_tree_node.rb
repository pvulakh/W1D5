require 'byebug'

class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        # debugger
        old_parent = self.parent
        if old_parent.nil?
            @parent = new_parent
            new_parent.children << self
        else
            old_parent.children.delete(self) 
            @parent = new_parent
            new_parent.children << self unless new_parent.nil?
        end
    end

    def add_child(child_node)
        child_node.parent = self 
    end

    def remove_child(child_node)
        raise "Not our child!" if !self.children.include?(child_node)
        self.children.delete(child_node) 
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            c_val = child.dfs(target_value)
            return c_val unless c_val == nil
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            first = queue.shift
            return first if first.value == target_value
            queue += first.children
        end
    end
end