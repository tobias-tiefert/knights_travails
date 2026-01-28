class Knight
  SYMBOL_WHITE = '♞'
  SYMBOL_BLACK = '♘'
  
  attr_accessor :position
  attr_reader :color, :symbol

  def initialize(color = 'white', position = [4, 4], game)
    @game = game
    @color = color
    @symbol = @color == 'white' ? SYMBOL_WHITE : SYMBOL_BLACK
    @position = position
    @moves = [
              {
                name: :up_left,
                x:  -1,
                y:  -2
            },
              {
                name: :up_right,
                x:  1,
                y:  -2
              },
              {
                name: :right_up,
                x:  2,
                y:  -1
              },
              {
                name: :right_down,
                x:  2,
                y:  1
              },
              {
                name: :down_right,
                x:  1,
                y:  2
              },
              {
                name: :down_left,
                x:  -1,
                y:  2
              },
              {
                name: :left_down,
                x:  -2,
                y:  1
              },
              {
                name: :left_up,
                x:  -2,
                y:  -1
              },
            ]
  end

  def move(new_position)
    return puts 'input must be no longer than 2 digits' if new_position.length > 2
    x = translate_x(new_position[0])
    y = translate_y(new_position[1])
    if valid_move?(x, y)
      @position = [x, y]
      @game.board.move_piece(self)
    else
      puts 'invalid move'
    end
  end

  def knight_moves (start_position, end_position)
    queue = [
            { 
              position: [translate_x(start_position[0]), translate_y(start_position[1])],
              path: [[translate_x(start_position[0]), translate_y(start_position[1])]]
            }
    ]
    result = knight_moves_recursive([translate_x(end_position[0]), translate_y(end_position[1])], queue)
    print_result(result)
    print_move_on_board(result)
  end

  

  private

  def print_result(path)
    puts ''
    puts "#{translate_back(path[0])} -> #{translate_back(path[path.length - 1]).to_s}"
    puts "You made it in #{path.length - 1} moves! Here's your path:"
    path.each_with_index do |position, index| 
      puts "#{index}: #{translate_back(position)}"
    end
  end

  def print_move_on_board(result)
    fields = []
    8.times do 
      fields << Array.new(8, nil)
    end
    result.each_with_index do |position, index| 
      symbol = if index == 0
              SYMBOL_BLACK
              elsif index == result.length - 1
                SYMBOL_WHITE
              else 
                index
              end
      fields[position[1]][position[0]] = symbol
    end
    @game.board.draw_board_knight_travails(fields)
  end

  def knight_moves_recursive(end_position, queue, visited = [])
    current = queue.shift
    visited << current[:position]
    if current[:position] == end_position
      return current[:path]
    else
      @moves.each do |move|
        move_position = [(current[:position][0] + move[:x]), (current[:position][1] + move[:y])]
        if visited.include?(move_position) || out_of_board?(move_position[0], move_position[1])
          next
        else 
          queue << {position: move_position, path: current[:path] + [move_position]}
        end
      end
      knight_moves_recursive(end_position, queue, visited)
    end
  end

  def valid_move?(x, y)
    if out_of_board?(x, y)
      return false
    else 
      @moves.each do |move|
        return true if @position[0] + move[:x] == x && @position[1] + move[:y] == y  
      end
      return false
    end
  end

  def out_of_board?(x, y)
    x < 0 || x > 7 || y < 0 || y > 7 ? true : false
  end

  def translate_x(position)
    position.ord - 'a'.ord
  end

  def translate_y(position)
    (position.to_i - 8).abs
  end

  def translate_x_back(number)
    (number + 'a'.ord).chr
  end

  def translate_y_back(number)
    (number - 8).abs
  end

  def translate_back(position)
    "#{translate_x_back(position[0])}#{translate_y_back(position[1])}" 
  end
  

end