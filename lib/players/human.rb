
module Players

    class Human < Player  
        def move(input)
            puts "Select position..."
            input = gets.chomp
        end
    end
    
end
