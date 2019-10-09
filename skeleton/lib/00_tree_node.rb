class PolyTreeNode
    attr_reader :parent, :children, :value
    attr_writer :parent, :children

    def inspect
        { 'value' => @value, 'parent' => @parent.value }.inspect
    end

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        @parent.children.delete(self) if !@parent.nil?
        @parent = new_parent
        @parent.children << self if !@parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "#{child_node.value} is not a child of #{@value}" if !@children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target)
        return self if @value == target

        @children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end

        nil
    end
    
end

