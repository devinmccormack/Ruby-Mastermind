class Code
  attr_reader :code

  # Constants to represent the colors that are used within the game
  COLORS = {
    'R' => 'Red',
    'B' => 'Blue',
    'G' => 'Green',
    'Y' => 'Yellow',
    'O' => 'Orange',
    'P' => 'Purple'
  }

  # Initializes the object for the code so that the game's code will be ready to be stored once it is created
  def initialize
    @code = []
  end

  # Takes the created code and sets it as such in the Code object.
  def set_code(code)
    code = code.join if code.is_a?(Array) # Convert array to string if necessary
    @code = code.upcase.chars
  end

  # Returns a generated code in an array
  def generate_random_code
    @code = Array.new(4) { COLORS.keys.sample }
  end

  # Creates feedback for a specific guess. First copies the code to ensure there are no misleading information in the feedback report
  # First identifies the letters that are in correct positions, and then looks at letters that are in the wrong position, determining
  # if they are meant to be in the code but only in the wrong position or if they are incorrect alltogether. 
  def generate_feedback(guess)
    guess = guess.join if guess.is_a?(Array) # Convert array to string if necessary
    feedback = []
    code_copy = @code.dup # Make a copy to track colors used in feedback
  
    # First pass: Identify correct positions
    guess.upcase.chars.each_with_index do |char, index|
      if char == code_copy[index]
        feedback[index] = 'correct'
        code_copy[index] = nil # Remove matched color
      end
    end
  
    # Second pass: Identify wrong positions
    guess.upcase.chars.each_with_index do |char, index|
      next if feedback[index] == 'correct' # Skip already matched positions
  
      if code_copy.include?(char)
        feedback[index] = 'wrong position'
        code_copy[code_copy.index(char)] = nil # Remove matched color
      else
        feedback[index] = 'incorrect'
      end
    end
  
    feedback
  end

  # Getter for the Code
  def reveal_code
    @code
  end
end