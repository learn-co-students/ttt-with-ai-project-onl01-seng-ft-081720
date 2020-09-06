module Players
    class Computer < Player
        def move(board)
            move = rand(9) + 1
            if board.valid_move?(move)
               return move.to_s
            elsif !board.valid_move?(move)
                move
            end
        end
    end
end