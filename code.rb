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
    code = code.join if code.is_a?(Array) # Convert array to string if necessary
    @code = code.upcase.chars
  end

  def generate_random_code
    @code = Array.new(4) { COLORS.keys.sample }
  end

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

  def reveal_code
    @code
  end
end