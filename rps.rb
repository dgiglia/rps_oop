module Playable
   MESSAGES = {
     'rock' => {'lizard' => "Rock crushes lizard.", 'scissors' => "Rock crushes scissors."},
     'paper' => {'rock' => "Paper covers rock.", 'spock' => "Paper disproves Spock."},
     'scissors' => {'paper' => "Scissors cut paper.", 'lizard' => "Scissors decapitate Lizard."},
     'lizard' => {'paper' => "Lizard eats Paper.", 'spock' => "Lizard poisons Spock."},
     'spock' => {'rock' => "Spock vaporizes Rock.", 'scissors' => "Spock smashes Scissors."}
   }
end

class PlayerHand
  include Playable
  attr_accessor :hand
  def choose_hand
    begin
      puts "Please type your choice (rock/paper/scissors/lizard/spock)"
      choice = gets.chomp.downcase
    end until MESSAGES.include?(choice) 
    self.hand = choice
  end
end

class ComputerHand
  include Playable
  attr_accessor :hand
  def choose_hand
    self.hand = MESSAGES.keys.sample
  end
end

class Game  
  include Playable
  attr_accessor :player, :computer, :winner

  def initialize 
    @player = PlayerHand.new
    @computer = ComputerHand.new
    @winner = winner
  end
  
  def greeting
    puts "Welcome to Rock-Paper-Scissors-Lizard-Spock, the ultimate boredom crushing game!"
  end
  
  def display_hands
    puts "    You chose #{player.hand.capitalize}." 
    puts "    The computer chose #{computer.hand.capitalize}."
  end
  
  def compare_hands(player, computer)
    if MESSAGES[player][computer]
      puts MESSAGES[player][computer]
      winner = player
    elsif MESSAGES[computer][player]
      puts MESSAGES[computer][player]
      winner = computer
    end

    if winner == player
      puts "**You won!**"
    elsif winner == computer
      puts "**You lost!**"
    else
      puts "It's a tie!"
    end
  end
  
  def play_again
    puts "Would you like to play again? (yes/no)"
    answer = gets.chomp.downcase   
    play if answer == 'yes'
  end
  
  def play
    system "clear"
    greeting
    player.choose_hand
    computer.choose_hand
    display_hands
    compare_hands(player.hand, computer.hand)
    play_again
  end
end

Game.new.play
