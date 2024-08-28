require './player.rb'
require './board.rb'
require './main.rb'
require './code.rb'

class Game
  def initialize(role)
    @board = Board.new
    @code = Code.new
    @codemaker = nil
    @codebreaker = nil
    setup_players(role)
  end

  def play
    setup_code

    until game_over?
      @board.display
      guess = @codebreaker.make_guess
      feedback = @code.generate_feedback(guess)
      @board.store_guess(guess, feedback)
      display_feedback(feedback)
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

  def game_over?
    @board.has_won?(@codebreaker.provide_guess)  || @board.guess_limit_reached?
  end

  def display_feedback(feedback)
    puts "Feedback: #{feedback}"
  end

  def end_game_message
    if @codebreaker.has_won?
      puts "#{@codebreaker.name} cracked the code! Congratulations!"
    else
      puts "The code created by #{@codemaker.name} remained unbroken!"
      puts "The code was: #{@code.reveal_code}"
    end
  end
end
