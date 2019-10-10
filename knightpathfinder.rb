require_relative 'skeleton/lib/00_tree_node'
class KnightPathFinder
    def initialize(start_pos)
        @root = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree(@root)
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

    def find_path(end_pos)
        target_node = @root.bfs(end_pos)
        print trace_path_back(target_node)
    end

    def trace_path_back(target_node)
        path = [target_node.value]
        until target_node == @root
            path << target_node.parent.value
            target_node = target_node.parent
        end
        path.reverse
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

if __FILE__ == $PROGRAM_NAME
    knight = KnightPathFinder.new([0,0])
    knight.find_path([7,6])
    knight.find_path([6,2])
end