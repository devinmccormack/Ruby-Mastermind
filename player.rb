require_relative 'Game'
require_relative 'Board'
require_relative 'Code'

class Player
  attr_accessor :name
  attr_reader :role

  # Constants to present the colors and the length of the code for validation purposes
  VALID_CHARACTERS = ['R', 'B', 'G', 'Y', 'O', 'P'].freeze
  CODE_LENGTH = 4 # Set the length of the code if needed

  # Initializes the Player and the Computer into their roles
  def initialize(name, role)
    @name = name
    @role = role
  end

  # The user is always assigned the name "You". Useful for deciding when input is necessary with overlapping methods for Player
  # and Computer alike. 
  def is_human?
    @name == "You"
  end

  # Determines if the guesser is the Player, or has the Computer randomly generate a guess. Requests the user's input to make a guess
  # Validates the guess, sending the error to the console as a string if one is sent and looping to allow the user make another
  # guess that meets the requirement, and returning said guess. 
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

  # Takes a code and then sets it as the secret code to be used for the game
  def set_code(code)
    raise "Only the codemaker can set the code." unless @role == 'codemaker'
    @code = code
  end

  # Gets input from the user, makes sure that it is in the correct format, and then returns it
  def create_code
    puts "Please enter the code (e.g., RGBY):"
    code = gets.chomp.upcase
    validate_code(code)
    code.chars
  end

  # Gets input from the user on their guess, validates it, and then returns the guess
  def provide_guess
    raise "Only the codebreaker can provide a guess." unless @role == 'codebreaker'
    guess = gets.chomp.upcase
    validate_guess(guess)
    guess.chars
  end

  private

  # Receives the user's guess, and validates that it meets the criteria of the preset constants before returning it
  def validate_guess(guess)
    guess_chars = guess.upcase.chars
    unless guess_chars.all? { |char| VALID_CHARACTERS.include?(char) }
      raise "Guess must only include the following characters: #{VALID_CHARACTERS.join(', ')}."
    end
    unless guess_chars.length == CODE_LENGTH
      raise "Guess must be exactly #{CODE_LENGTH} characters long."
    end
  end

  # Receives the user's created code, and validates that it meets the criteria of the preset constants before returning it
  def validate_code(code)
    code_chars = code.upcase.chars
    unless code_chars.all? { |char| VALID_CHARACTERS.include?(char) }
      raise "Code must only include the following characters: #{VALID_CHARACTERS.join(', ')}."
    end
    unless code_chars.length == CODE_LENGTH
      raise "Code must be exactly #{CODE_LENGTH} characters long."
    end
  end

  # Serves as the Computer's guess input, returning their guess
  def generate_random_guess
    Array.new(CODE_LENGTH) { VALID_CHARACTERS.sample }
  end
  
end
