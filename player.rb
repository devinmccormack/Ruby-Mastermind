require_relative 'Game'
require_relative 'Board'
require_relative 'Code'

class Player
  attr_accessor :name
  attr_reader :role

  VALID_CHARACTERS = ['R', 'B', 'G', 'Y', 'O', 'P'].freeze
  CODE_LENGTH = 4 # Set the length of the code if needed

  def initialize(name, role)
    @name = name
    @role = role
  end

  def is_human?
    @name == "You"
  end

  def make_guess
    if is_human?
      loop do
        puts "#{@name}, please enter your guess (e.g., RGBY):"
        guess = gets.chomp.upcase
        begin
          validate_guess(guess)
          return guess.chars
        rescue => e
          puts e.message
        end
      end
    else
      generate_random_guess
    end
  end

  def set_code(code)
    raise "Only the codemaker can set the code." unless @role == 'codemaker'
    @code = code # This should be handled by Code class
  end

  def provide_guess
    raise "Only the codebreaker can provide a guess." unless @role == 'codebreaker'
    guess = gets.chomp.upcase
    validate_guess(guess)
    guess.chars
  end

  private

  def validate_guess(guess)
    guess_chars = guess.upcase.chars
    unless guess_chars.all? { |char| VALID_CHARACTERS.include?(char) }
      raise "Guess must only include the following characters: #{VALID_CHARACTERS.join(', ')}."
    end
    unless guess_chars.length == CODE_LENGTH
      raise "Guess must be exactly #{CODE_LENGTH} characters long."
    end
  end

  def generate_random_guess
    Array.new(CODE_LENGTH) { VALID_CHARACTERS.sample }
  end
  
end
