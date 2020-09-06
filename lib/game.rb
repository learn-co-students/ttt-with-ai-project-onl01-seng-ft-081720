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
        [6,4,2],     
    ]

    def run
        # Greet the user with a message.
        puts "Hello, player!"
        # Prompt the user for what kind of game they want to play, 0,1, or 2 player.
        puts "How many players? 0, 1, or 2?"
        input = gets.chomp
        if input.to_i == 0
            game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"), Board.new)
        elsif input.to_i == 1
            game = Game.new(Players::Human.new("X"), Players::Computer.new("O"), Board.new)
        elsif input.to_i == 2
            game = Game.new(Players::Human.new("X"), Players::Human.new("O"), Board.new)
        else
            puts "Sorry I didn't get that."
            run
        end
        play
        puts "Great game! Would you like to play again? Y/N"
        input = gets.chomp
        if input.upcase == "Y"
            run
        end
    end

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
      @board = board
      @player_1 = player_1
      @player_2 = player_2
    end

    def current_player
        @board.turn_count.even? ? @player_1 : @player_2
    end

    # def winning_combos_met?
    #     WIN_COMBINATIONS.each do |combo|
    #         if combo.all?(/X|O/) 
    #             return true
    #         end
    #     end
    # end

    def won? 
        WIN_COMBINATIONS.any? do |combo| 
            if combo.all? {|i| board.cells[i] == "X"}
                return combo
            elsif combo.all? {|i| board.cells[i] == "O"}
                return combo
            end

        end
    end

    def draw?
        !won? && board.full?
    end

    def over?
        draw? || won?
    end

    def winner
        #game has to be over
        #nil if draw
        if !over? || draw?
            nil
        else
            board.cells[won?[0]]
        end
    end

    def turn
        input = current_player.move(board) 
        if board.valid_move?(input)
            board.update(input, current_player)
        elsif !board.valid_move?(input)
            print "why isnt this working" 
            current_player.move(board)
        end
    end

    def play 
        puts "Please enter a number 1-9."
        if over?
            if draw?
                puts "Cat's Game!"
                return "how do I end recursion?"
            end
            if won?
                puts "Congratulations #{winner}!" 
                return "how do I end recursion?"
            end
        else
        turn
        play
        end
    end
end