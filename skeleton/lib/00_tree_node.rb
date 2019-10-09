class PolyTreeNode
    attr_reader :parent, :value
    attr_writer :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def children
        # We dup to avoid someone inadvertently trying to modify our
        # children directly through the children array. Note that
        # `parent=` works hard to make sure children/parent always match
        # up. We don't trust our users to do this.
        @children.dup
    end   

    def parent=(new_parent)
        @parent._children.delete(self) if @parent
        @parent = new_parent
        @parent._children << self if @parent
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "#{child_node.value} is not a child of #{@value}" if !_children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target)
        return self if @value == target

        _children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end

        nil
    end

    def bfs(target)
        queue = [self]

        until queue.empty?
            node = queue.shift
            return node if node.value == target
            node._children.each { |child| queue << child }
        end
    end

    # Protected method to give a node direct access to another node's
    # children.
    def _children
        @children
    end
    
end

