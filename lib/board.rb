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

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def position(user_input)
        @cells[input_to_index(user_input)]
    end

    def full?
        @cells.all?{|square| square != " " }
    end

    def turn_count
        @cells.count{|square| square != " " }
    end

    def taken?(user_input)
        index = input_to_index(user_input)
        @cells[index] != " "
    end

    def valid_move?(user_input)
        !taken?(user_input) && user_input.to_i.between?(1,9)
    end

    def update(user_input, player)
        index = input_to_index(user_input)
        @cells[index] = player.token
    end

end