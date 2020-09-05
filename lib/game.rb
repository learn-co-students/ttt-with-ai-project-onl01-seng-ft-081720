class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
      @board.turn_count.even? ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.any? do |combo| if 
            @board.taken?(combo[0] + 1) &&
            @board.cells[combo[0]] == @board.cells[combo[1]] && 
            @board.cells[combo[1]] == @board.cells[combo[2]]
            return combo
        end
        end
    end
        
    def draw?
        @board.full? &&  !won?
    end
        
    def over?
        @board.full? || won? || draw?
    end
        
    def winner 
        @board.cells[won?[0]] if won?
    end

    def turn
        @board.display
        puts "It is #{current_player.token}'s turn!"
        index = current_player.move(@board).to_i
        if @board.valid_move?(index)
            @board.update(index,current_player)
        else
        "Invalid move. Please try again"
        turn
        end
    end

    def play 
        while over? == false
            turn        
        end       
        if won?           
            puts "Congratulations #{winner}!"
        else            
            puts "Cat's Game!"        
        end    
    end

end

# require 'pry'
# class TicTacToe

#     WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
  
#     def initialize
#       @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
#     end
  
    
#     def move(index, piece)
#       @cells[index] = piece
#     end

  
#     def valid_move?(index)
#       index.between?(0,8) && !position_taken?(index)
#     end
  
#     def current_player
#       turn_count.even? ? "X" : "O"
#     end
  
#     def turn
#       puts "Choose your move wisely (1-9):"
#       user_input = gets.strip
#       index = input_to_index(user_input)
#       if valid_move?(index)
#           piece = current_player
#           move(index, piece)
#       else
#         "Please select a valid choice."
#         turn
#       end
#       display_cells
#     end

#     def won?
#        a = WIN_COMBINATIONS.detect{
#            |combo|
#            @cells[combo[0]] == "X" &&
#            @cells[combo[1]] == "X" &&
#            @cells[combo[2]] == "X" 
#        }
#        b = WIN_COMBINATIONS.detect{
#             |combo|
#             @cells[combo[0]] == "O" &&
#             @cells[combo[1]] == "O" &&
#             @cells[combo[2]] == "O" 
#        }
#         a||b
#     end

#     def full?
#         @cells.all?{|x| x != " "}
#     #returns
#     end

#     def draw?
#         !won? && full?
#     end

#     def over?
#         full? || won? || draw?
#     end

#     def winner 
#        if won?
#          @cells[won?[0]] == "X" ? "X" : "O"
#        else
#         nil
#        end
#     end

#     def play 
#         while over? == false
#         turn        
#         end       
#         if won?           
#             puts "Congratulations #{winner}!"
#         else            
#             puts "Cat's Game!"        
#         end    
#     end
# end
#our cells
# 0  1  2
# 3  4  5
# 6  7  8

#users cells
#1  2  3
#4  5  6
#7  8  9