require 'pry'
class Game
 
    attr_accessor :board , :player_1 ,:player_2

    WIN_COMBINATIONS= [
        [0,1,2], #top row 
        [3,4,5], #middle
        [6,7,8], #bottom
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
        ]
        
    def initialize(player_1=Players::Human.new("X"),player_2=Players::Human.new("O"),board=Board.new)
        @player_1=player_1
        @player_2=player_2
        @board=board
    end

    def current_player
        if board.turn_count % 2 == 0 
            player_1
        else 
            player_2
        end
    end

    def won?
        WIN_COMBINATIONS.each do |i|
            win_index_1=i[0]
            win_index_2=i[1]
            win_index_3=i[2]
            position_1 = board.cells[win_index_1] 
            position_2 = board.cells[win_index_2] 
            position_3 = board.cells[win_index_3] 
            if position_1 == "X" && position_2 == "X" && position_3 == "X"
              return i
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
              return i
            end
        end
        false
    end

    def draw?
         board.full? && !won? 
    end

    def over?
        draw? || won? 
    end

    def winner
        winner_index= won?
        if winner_index==false
            nil
        elsif winner_index.all? do |i|
            board.cells[i]=="X"
        end
            "X"
        elsif winner_index.all? do |j|
            board.cells[j]=="O"
        end
            "O"
        end
    end


    def turn
            puts "It is #{current_player.token}'s turn!"
            input = current_player.move(board)
            if board.valid_move?(input) 
                board.update(input,current_player)
                board.display
            else 
                turn 
            end
    end

    def play 
        turn until over?
        if  draw? 
            puts "Cat's Game!"
        else
            puts "Congratulations #{winner}!"
        end
    end

    
end
# binding.pry