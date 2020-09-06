module Players
  class Human < Player
    
    def move(board)
      puts "Please enter your selection:"
      gets.chomp
    end 
  end 
end 