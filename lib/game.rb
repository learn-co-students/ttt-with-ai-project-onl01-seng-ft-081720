class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
    
    def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count.even? ? player_1 : player_2
    end
    
    def won?
        WIN_COMBINATIONS.any? do |combo|
          if @board.taken?(combo[0] + 1) && @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]]
            return combo
          end
        end
    end

    def draw?
        @board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        @board.cells[won?[0]] if won?
    end

    def turn
        @board.display
0
        puts "It is #{current_player.token}'s turn!"
        index = current_player.move(@board).to_i

        if @board.valid_move?(index) 
            @board.update(index, current_player)
        else            
            puts "Invalid move. Please try again" # Fix later :(
            turn
        end
    end

    def play 
        turn until over?
        if won?
            @board.display
            puts "Congratulations #{winner}!"
        else
            @board.display
            puts "Cat's Game!"
        end
    end

    def turn_ai
        @board.display

        puts "It is #{current_player.token}'s turn!"
        index = current_player.move(@board).to_i

        if @board.valid_move?(index)
            @board.update(index, current_player)
            sleep(2)
        else            
            puts "Invalid move. Please try again" # Fix later :(
            turn
        end
    end

    def play_ai
        turn_ai until over?
        if won?
            @board.display
            puts "Congratulations #{winner}!"
        else
            @board.display
            puts "Cat's Game!"
        end
    end

end