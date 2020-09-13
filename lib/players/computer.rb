require_relative '../player.rb'
require_relative '../game.rb'
require 'pry'
# ruby computer.rb
module Players
    class Computer < Player
        attr_accessor :killer
        
        def killer
            @killer = false
        end

        def opponent
            @game.player_1 == self ? @game.player_2 : @game.player_1
        end

        def combos
            Game::WIN_COMBINATIONS
        end

        def block_shot(board)
            move = nil
            combos.each.with_index do |arr|
                checker = [board.cells[arr[0]], board.cells[arr[1]], board.cells[arr[2]]]
                if checker.select{|cell| cell == opponent.token} .length == 2 && checker.include?(" ")
                    i = checker.index(" ")
                    move = "#{arr[i] + 1}"
                end
            end
            move
        end

        def kill_shot(board)
            move = nil
            combos.each do |arr|
                spots = arr.map{|i| board.cells[i]}  #[board.cells[arr[0]], board.cells[arr[1]], board.cells[arr[2]]]
                if spots.select{|cell| cell == self.token} .length == 2 && spots.include?(" ")
                    move = "#{arr.find{|i| board.cells[i] == " "} + 1}"
                end
            end
            move
        end

        def second_combos
            array = [   
                [0,5,7],    #these represent the corner and side combos
                [2,3,7],    #that I want to leverage 
                [6,1,5],    #=> if array[i][0] == true ? my move is the one not taken
                [8,1,3]
            ]
        end

        def corner_side(board)
            move = nil
            second_combos.each do |arr|
                if board.cells[arr[0]] == opponent.token && arr[1] != arr[2]
                    move = "#{(arr.find{|x| board.cells[x] == " "} + 1)}"
                end
            end
            move
        end

        def corners(board)
            array = [0,2,6,8]
            if board.cells[4] == opponent.token && board.cells[8] == opponent.token
                '3'
            elsif array.select{|i| board.cells[i] == opponent.token} .length == 2 
                '2'
            end
        end

        def sides(board)
            board.cells[5] == opponent.token && board.cells[7] == opponent.token ? '3' : '1'
        end

        def opportunist(board)
            checker = "#{self.token}#{opponent.token}#{opponent.token}#{self.token}#{opponent.token}"
            board = board.cells
            if checker == [board[0], board[1], board[4], board[7], board[8]].join()
                '4'
            elsif checker == [board[0], board[3], board[4], board[5], board[8]].join()
                '2'
            end
        end

        def first(board)
            board.cells[4] == " " ? "5" : "1"
        end

        def second(board)
            arr = [block_shot(board), corner_side(board), corners(board), sides(board)]
            response = arr.detect{|x| x}
        end

        def third(board)
            arr = [kill_shot(board), block_shot(board), opportunist(board), "#{board.cells.index(" ") + 1}"]
            response = arr.detect{|x| x}
        end

        def final(board)
            arr = [kill_shot(board), block_shot(board), "#{board.cells.index(" ") + 1}"]
            response = arr.detect{|x| x}
        end

        def control(board)
            if board.cells[1] == opponent.token || board.cells[3] == opponent.token
                @killer = true
                '1'
            elsif board.cells[5] == opponent.token || board.cells[7] == opponent.token
                @killer = true
                '9'
            end
        end

        def defend(board)
            board.cells[0] == opponent.token || board.cells[8] == opponent.token ? '3' : '1'
        end

        def control_two(board)
            if board.cells[0] == self.token 
                board.cells[1] == opponent.token ? '4' : '2'
            elsif board.cells[0] == opponent.token
                board.cells[7] == opponent.token ? '6' : '8'
            end
        end

        def p1_second(board)
            control(board) ? control(board) : defend(board)
        end

        def p1_third(board)
            if @killer
                kill_shot(board) ? kill_shot(board) : control_two(board)
            else 
                final(board)
            end
        end

        def computer_move(board)
            case board.turn_count
            when 0
                '5'
            when 1
                first(board)
            when 2
                p1_second(board)
            when 3
                second(board)
            when 4
                p1_third(board)
            when 5
                third(board)
            else
                final(board)
            end
        end

        def move(board)
            sleep 1.5 ; puts " "
            puts "!!! BOOM !!!"
            computer_move(board)
        end
    end
end

