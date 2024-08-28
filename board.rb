require_relative 'Code'
require_relative 'Game'

class Board
  MAX_GUESSES = 12

  def initialize(code)
    @code = code
    @guesses = []
  end

  def display
    puts "Current Board:"
    @guesses.each_with_index do |(guess, feedback), index|
      puts "Guess ##{index + 1}: #{guess.join(' ')} | Feedback: #{feedback.join(' ')}"
    end
  end

  def store_guess(guess, feedback)
    @guesses << [guess, feedback]
  end

  def guess_limit_reached?
    @guesses.length >= MAX_GUESSES
  end

  def has_won?(guess)
    guess_array = convert_to_array(guess)
    guess_array == @code.reveal_code
  end

  private

  def convert_to_array(input)
    return input if input.is_a?(Array) # Return input if already an array
    input.upcase.chars
  end
end