require_relative 'skeleton/lib/00_tree_node'
class KnightPathFinder
    def initialize(start_pos)
        # @root = build_move_tree(start_pos)
        print valid_moves(start_pos)
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
end
KnightPathFinder.new([3,3])