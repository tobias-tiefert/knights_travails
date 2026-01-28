class Board
  BLACK_EMPTY_FIELD = '   |'
  WHITE_EMPTY_FIELD = '///|'
  ROW_POSITIONS = '   a   b   c   d   e   f   g   h  '

  # c3 h8 a1 ...
  def initialize(game)
    @game = game
    @fields = create_fields
    draw_board
  end

  def draw_board(fields = @fields)
    puts ROW_POSITIONS

    fields.each_with_index do |row, row_index|
      draw_column = "#{(row_index-8).abs}|"
      row.each_with_index do |column, col_index|
        if row_index.odd?
          if column.nil?
            field = col_index.odd? ? BLACK_EMPTY_FIELD : WHITE_EMPTY_FIELD
          else
            field =  col_index.odd? ? " #{column.symbol} |" : "/#{column.symbol}/|"
          end
        else
          if column.nil?
            field = col_index.even? ? BLACK_EMPTY_FIELD : WHITE_EMPTY_FIELD
          else
            field =  col_index.even? ? " #{column.symbol} |" : "/#{column.symbol}/|"
          end
        end
        draw_column += field
      end
      puts draw_column
    end
  end

  def draw_board_knight_travails(fields)
    puts ROW_POSITIONS

    fields.each_with_index do |row, row_index|
      draw_column = "#{(row_index-8).abs}|"
      row.each_with_index do |column, col_index|
        if row_index.odd?
          if column.nil?
            field = col_index.odd? ? BLACK_EMPTY_FIELD : WHITE_EMPTY_FIELD
          else
            field =  col_index.odd? ? " #{column} |" : "/#{column}/|"
          end
        else
          if column.nil?
            field = col_index.even? ? BLACK_EMPTY_FIELD : WHITE_EMPTY_FIELD
          else
            field =  col_index.even? ? " #{column} |" : "/#{column}/|"
          end
        end
        draw_column += field
      end
      puts draw_column
    end
    puts 'Start: ♘ | End: ♞'
  end

  def put_on_board(piece, position = piece.position)
    @fields[position[1]][position[0]] = piece
  end

  def move_piece(piece)
    old_position = position(piece)
    @fields[old_position[0]][old_position[1]] = nil
    @fields[piece.position[1]][piece.position[0]] = piece
    draw_board
  end

  private

  def position(piece)
    @fields.each_with_index do |row, row_index|
      row.each_with_index do |field, col_index|
        return [row_index, col_index] if field == piece
      end
    end
  end

  def create_fields
    fields = []
    8.times do 
      fields << Array.new(8, nil)
    end
    fields
  end

end