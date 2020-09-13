class Player

    attr_accessor :board, :game
    attr_reader :token

    def initialize(token)
        @token = token
    end

    def move(board)
        puts "Make your move! (1-9)"
        input = gets.strip
    end
end