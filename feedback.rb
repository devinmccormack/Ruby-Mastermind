class Feedback
  def initialize(code, guess)
    @code = code
    @guess = guess
  end

  def generate_feedback
    correct = count_correct_positions
    incorrect_position = count_incorrect_positions
    {
      correct: correct,
      incorrect_position: incorrect_position
    }
  end

  private

  def count_correct_positions
    @code.each_with_index.count do |color, index|
      color == @guess[index]
    end
  end

  def count_incorrect_positions
    code_counts = count_colors(@code)
    guess_counts = count_colors(@guess)

    common_colors = code_counts.keys & guess_counts.keys
    correct_color_count = common_colors.sum do |color|
      [code_counts[color], guess_counts[color]].min
    end

    correct_color_count - count_correct_positions
  end

  def count_colors(array)
    array.each_with_object(Hash.new(0)) { |color, counts| counts[color] += 1 }
  end
end
