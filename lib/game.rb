require 'pry'
class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    
    def initialize(p1=Players::Human.new("X"),p2=Players::Human.new("O"),board=Board.new)
        @player_1 = p1
        @player_2 = p2
        @board = board
        @player_1.game = self
        @player_2.game = self
    end

    def current_player
        @board.turn_count.even? ? player_1 : player_2
    end
    
    def won?
        win = false
        WIN_COMBINATIONS.each do |combo|
            one = combo[0] ; two = combo[1] ; three = combo[2]
            board = @board.cells
            if [board[one], board[two], board[three]].all?{|x| x == player_1.token} || [board[one], board[two], board[three]].all?{|x| x == player_2.token}
                win = combo
            end
        end
        win
    end

    def draw?
        !won? && @board.full?
    end

    def over?
        draw? || won?
    end

    def winner
        winner = nil
        WIN_COMBINATIONS.each do |combo|
            one = combo[0] ; two = combo[1] ; three = combo[2]
            board = @board.cells
            if [board[one], board[two], board[three]].all?{|x| x == player_1.token} 
                winner = player_1.token
            elsif [board[one], board[two], board[three]].all?{|x| x == player_2.token}
                winner = player_2.token
            end
        end
        winner
    end

    def invalid
        puts "Invalid entry, please try again."
        turn
    end

    def turn
        puts " " ; @board.display ; puts " "
        player = current_player
        move = player.move(@board)
        @board.valid_move?(move) ? @board.update(move, player) : invalid
    end

    def congrats
        puts "Congratulations #{winner}!"
    end

    def cats
        puts "Cat's Game!"
    end

    def play
        while !over?
            turn          
        end
        winner ? congrats : cats
    end
end