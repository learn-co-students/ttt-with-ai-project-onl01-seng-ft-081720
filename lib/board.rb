

class Board
attr_accessor :cells

    def initialize
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def reset!
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]   
    end

    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(input)
        @cells[input.to_i - 1]
    end

    def full?
        @cells.all? {|position| position == "X" || position == "O"}
    end

    def turn_count
        count = 0
        @cells.each do |position|
            count +=1 if position == "X" || position == "O"
        end
        count
    end

    def taken?(input)
        @cells[input.to_i - 1] == "X" || @cells[input.to_i - 1] == "O"
    end

    def valid_move?(input)
        !taken?(input) && input.to_i.between?(1,9)
        # binding.pry
    end

    def update(input, player)
        @cells[input.to_i - 1] = player.token
        puts "#{self}"
        # binding.pry
    end










end
