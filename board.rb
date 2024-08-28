require_relative 'Code'
require_relative 'Game'

class Board
  # Constant variable serving as the total number of guesses the Codebreaker can use before they lose
  MAX_GUESSES = 12

  # Initializes the storage for the guesses as well as the already created code
  def initialize(code)
    @code = code
    @guesses = []
  end

  # Displays all of the guesses made so far along with their feedback to the console after each guess the Codebreaker makes
  def display
    puts "Current Board:"
    @guesses.each_with_index do |(guess, feedback), index|
      puts "Guess ##{index + 1}: #{guess.join(' ')} | Feedback: #{feedback.join(' ')}"
    end
  end

  # Adds the guess and the feedback to the guesses
  def store_guess(guess, feedback)
    @guesses << [guess, feedback]
  end

  # Determines whether or not the maximum amount of guesses have been used yet
  def guess_limit_reached?
    @guesses.length >= MAX_GUESSES
  end

  # Determines whether or not the Codebreaker's guess matches with the Codemaker's code, ensuring it is the correct format as well
  def has_won?(guess)
    guess_array = convert_to_array(guess)
    guess_array == @code.reveal_code
  end

  private

  # Converts an input into an array, useful for matching up the input with the code being stored already
  def convert_to_array(input)
    return input if input.is_a?(Array) # Return input if already an array
    input.upcase.chars
  end
end