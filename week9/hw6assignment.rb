# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here

  # your enhancements here
  def self.next_piece (cheat,board)
    if cheat
      MyPiece.new([[[0,0]]], board)
    else
      MyPiece.new(All_My_Pieces.sample, board)
    end
  end
  
  All_My_Pieces = All_Pieces + 
               [[[[0, 0], [-1, 0], [1, 0], [2, 0],[3,0]], # long 5(only needs two)
                 [[0, 0], [0, -1], [0, 1], [0, 2],[0,3]]],
                rotations([[0, 0], [-1, 0], [-1, -1], [1, 0], [0, -1]]), # T+1
                rotations([[0, 0], [0, 1], [1, 0]])] # T-1
end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(@cheat, self)
    @score = 0
    @game = game
    @delay = 500
    @cheat = false
  end
  
  def rotate_180
    rotate_clockwise
    rotate_clockwise
  end

  def cheat_n
    if !game_over? and @game.is_running?
      if !@cheat and @score >= 100
        @score -= 100
        @cheat = true
      end
    end
  end

  def next_piece
      @current_block = MyPiece.next_piece(@cheat, self)
      @current_pos = nil
      @cheat = false
  end

  # store all information for new-added pieces since
  # they are more than 4 dims
  def store_current  
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..locations.size-1).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat_n})
  end
end

