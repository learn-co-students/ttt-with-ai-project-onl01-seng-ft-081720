
# require_relative '/players/human.rb'

class Game
    # extend Players::Human
    attr_accessor :player_1, :player_2, :board

    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]


    def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board = Board.new)
        @board = board
        # THERE ARE NO VARIABLES TO INITIAL BOARD. Why?
        @player_1 = player_1
        @player_2 = player_2
    end

    def current_player
        @board.turn_count.even? ? player_1 : player_2
    end

    def won?
        current_board = @board.cells

        WIN_COMBINATIONS.detect do |c|
            spot_1 = current_board[c[0]]
            spot_2 = current_board[c[1]]
            spot_3 = current_board[c[2]]
            spot_1 == spot_2 && spot_2 == spot_3 && spot_1 == spot_3 && spot_1 != " "
        end
    end

    def full?
        !@board.cells.any?(" ") && !won? #are any cells open? => false
    end

    def draw?
        !self.won? && self.full?
    end

    def over? 
        self.draw? || self.won?
    end

    def winner
        if self.won?
            array = self.won?
            ch = @board.cells[array[0]]
        else
            nil   
        end
    end

    def turn
        puts "Select a position 1 - 9:"

        input = current_player.move(current_player.token)
        
        if @board.valid_move?(input)
            @board.update(input, current_player)
            @board.display
        else
            self.turn
        end
    end

    def play
        while !self.over? do 
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"
        end

        if self.draw?
            puts "Cat's Game!"
        end
    end
end
