require "pry"

class Game

  attr_accessor :board, :player_1, :player_2

  @board = []

  WIN_COMBINATIONS = [
    [0, 1, 2], # top row
    [3, 4, 5], # mid row
    [6, 7, 8], # bottom row
    [0, 3, 6], # left col
    [1, 4, 7], # mid col
    [2, 5, 8], # right col
    [0, 4, 8], # l-to-r diagonal
    [2, 4, 6] # r-to-l diagonal
  ]

  def initialize(p1=Players::Human.new("X"), p2=Players::Human.new("O"), b=Board.new)
    @player_1 = p1
    @player_2 = p2
    @board = b
  end

  def board
    @board
  end

  def player_1
    @player_1
  end

  def player_2
    @player_2
  end

  def current_player
    if board.turn_count.odd?
      @player_2
    elsif board.turn_count.even?
      @player_1
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combo|
      if @board.cells[win_combo[0]] == @board.cells[win_combo[1]] && @board.cells[win_combo[0]] == @board.cells[win_combo[2]]
        if @board.taken?(win_combo[0]) == true
          return win_combo
        end
      end
    end
  end

  def draw?
    not won? and @board.full?
  end

  def over?
    won? or draw?
  end

  def winner
    if draw?
      nil
    elsif won?
      @board.cells[won?[0]]
    end
  end

end
