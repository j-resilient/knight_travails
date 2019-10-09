class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(el)
        @parent = el
        @children << parent if !parent.nil?
    end
end