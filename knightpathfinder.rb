require_relative 'skeleton/lib/00_tree_node'
class KnightPathFinder
    def initialize(start_pos)
        @root = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree(@root)
        print_tree
    end

    def valid_moves(pos)
        moves = []
        pos_x, pos_y = pos

        x_addends = [-2, 2, 1, -1]
        x_addends.each do |x_addend|
            next if !(pos_x + x_addend).between?(0,7)
            x = pos_x + x_addend

            y_addend = x_addend.abs == 2 ? 1 : 2
            moves << [x, pos_y - y_addend] if (pos_y - y_addend).between?(0,7)
            moves << [x, pos_y + y_addend] if (pos_y + y_addend).between?(0,7)
        end

        moves
    end

    def new_move_positions(pos)
        moves = valid_moves(pos).delete_if { |move| @considered_positions.include?(move) }
        @considered_positions += moves
        moves
    end

    def build_move_tree(start_pos)
        queue = [start_pos]
        until queue.empty?
            node = queue.shift
            new_move_positions(node.value).each do |move|
                new_node = PolyTreeNode.new(move)
                node.add_child(new_node)
                queue << new_node
            end
        end
    end

    def print_tree
        queue = [@root]
        print "#{@root.value}\n"
        until queue.empty?
            node = queue.shift
            print "#{node.value}:   "
            node.children.each do |child| 
                print "#{child.value} "
                queue << child
            end
            puts
        end
    end
end
KnightPathFinder.new([3,3])