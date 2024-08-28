require_relative 'Player'
require_relative 'Board'
require_relative 'Code'

class Game
  def initialize(role)
    @codemaker = nil
    @codebreaker = nil
    setup_players(role)
    @code = Code.new
    setup_code
    @board = Board.new(@code)
  end

  def play
    win = false

    until @board.guess_limit_reached? || win == true
      @board.display
      guess = @codebreaker.make_guess
      feedback = @code.generate_feedback(guess)
      @board.store_guess(guess, feedback)
      display_feedback(feedback)
      if (@board.has_won?(guess))
        win = true
        break
      end
    end
    end_game_message
  end

  private

  def setup_players(role)
    if role == 'codemaker'
      @codemaker = Player.new("You", :human)
      @codebreaker = Player.new("Computer", :computer)
    else
      @codemaker = Player.new("Computer", :computer)
      @codebreaker = Player.new("You", :human)
    end
  end

  def setup_code
    if @codemaker.is_human?
      code = @codemaker.create_code
      @code.set_code(code)
    else
      @code.generate_random_code
    end
  end

  def display_feedback(feedback)
    puts "Feedback: #{feedback}"
  end

  def end_game_message
    if @board.guess_limit_reached?
      puts "The code created by #{@codemaker.name} remained unbroken!"
      puts "The code was: #{@code.reveal_code.join}"
    else
      puts "#{@codebreaker.name} cracked the code! Congratulations!"
    end
  end
end
