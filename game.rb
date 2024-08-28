require_relative 'Player'
require_relative 'Board'
require_relative 'Code'

class Game
  # In specific order, initializes the objects needed to play the game and sets up the code based upon
  # the player's role in reference to the Computer's role.
  def initialize(role)
    @codemaker = nil
    @codebreaker = nil
    setup_players(role)
    @code = Code.new
    setup_code
    @board = Board.new(@code)
  end

  # Loops until the codebreaker either guesses the correct code or runs out of guesses
  def play
    win = false
    until @board.guess_limit_reached? || win == true
      @board.display
      guess = @codebreaker.make_guess
      feedback = @code.generate_feedback(guess)
      @board.store_guess(guess, feedback)
      display_feedback(feedback)
      # Checks if the code is correct, breaking out of the loop if true
      if (@board.has_won?(guess))
        win = true
        break
      end
    end
    # Informs the user of who won the game and then returns to main
    end_game_message
  end

  private

  # Takes the user's previously inputted role and assigns them and the Computer a Player object
  def setup_players(role)
    if role == 'codemaker'
      @codemaker = Player.new("You", :human)
      @codebreaker = Player.new("Computer", :computer)
    else
      @codemaker = Player.new("Computer", :computer)
      @codebreaker = Player.new("You", :human)
    end
  end

  # Prompts the codemaker player to create a code, or has the Computer generate it if the user is the Codebreaker
  def setup_code
    if @codemaker.is_human?
      code = @codemaker.create_code
      @code.set_code(code)
    else
      @code.generate_random_code
    end
  end

  # Displays the feedback given on the most recent guess by Codebreaker
  def display_feedback(feedback)
    puts "Feedback: #{feedback}"
  end

  # Determines whether or not the Codemaker has won by having their opponent reach the guess_limit, and congratulates
  # the winning accordingly, revealing the code if the Codemaker succeeds.
  def end_game_message
    if @board.guess_limit_reached?
      puts "The code created by #{@codemaker.name} remained unbroken!"
      puts "The code was: #{@code.reveal_code.join}"
    else
      puts "#{@codebreaker.name} cracked the code! Congratulations!"
    end
  end
end
