require_relative 'lib/Game'
require_relative 'lib/Board'
require_relative 'lib/Knight'

game = Game.new
board = game.board
knight = game.knight



knight.knight_moves('f7', 'b3')