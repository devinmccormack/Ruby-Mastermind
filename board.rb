class Board
  MAX_GUESSES = 12

  def initialize
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
    guess == @code
  end
end