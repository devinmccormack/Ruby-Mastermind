require './player.rb'
require './board.rb'
require './game.rb'
require './code.rb'

class Main
  def self.start
    puts "Welcome to Mastermind!"
    role = nil
    
    loop do
      puts "Do you want to be the codemaker or the codebreaker? (codemaker/codebreaker)"
      role = gets.chomp.downcase
      if (role == 'codemaker' || role == 'codebreaker')
        break
      else 
        puts "Please choose a valid role to play the game."
      end
    end

    # Start a new game with player's role
    game = Game.new(role)
    game.play

    # Option to restart the game
    puts "Do you want to play again? (yes/no)"
    answer = gets.chomp.downcase
    if answer == "yes"
      start # Recursively call start to restart the game
    else
      puts "Thanks for playing!"
    end
  end
end

Main.start