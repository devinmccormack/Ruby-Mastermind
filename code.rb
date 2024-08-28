require './player.rb'
require './board.rb'
require './game.rb'
require './main.rb'

class Code
  attr_reader :code

  COLORS = {
    'R' => 'Red',
    'B' => 'Blue',
    'G' => 'Green',
    'Y' => 'Yellow',
    'O' => 'Orange',
    'P' => 'Purple'
  }

  def initialize
    @code = []
  end

  def set_code(code)
    @code = code.upcase.chars
  end

  def generate_random_code
    @code = Array.new(4) { COLORS.keys.sample }
  end

  def generate_feedback(guess)
    feedback = []
    guess.upcase.chars.each_with_index do |char, index|
      if char == @code[index]
        feedback << 'correct'
      elsif @code.include?(char)
        feedback << 'wrong position'
      else
        feedback << 'incorrect'
      end
    end
    feedback
  end

  def reveal_code
    @code.join
  end
end