class Game
  attr_reader :board, :knight
  def initialize
    @board = Board.new(self)
    @knight = Knight.new(self)
  end
end