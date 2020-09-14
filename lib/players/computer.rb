module Players
    class Computer < Player

        def move(board)
            if !board.taken?('5')
                '5'
            else 
                best_move(board) + 1
            end
        end

        def best_move(board)
            win(board) || block(board) || random
        end

        def corner(board)
            [0,2,6,8].detect {|cell| !board.taken?(cell+1)}
        end


    end
end