module Playable
  CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  ROCK = {'lizard' => "Rock crushes lizard.", 'scissors' => "Rock crushes scissors."}
  PAPER = {'rock' => "Paper covers rock.", 'spock' => "Paper disproves Spock."}
  SCISSORS = {'paper' => "Scissors cut paper.", 'lizard' => "Scissors decapitate Lizard."}
  LIZARD = {'paper' => "Lizard eats Paper.", 'spock' => "Lizard poisons Spock."}
  SPOCK = {'rock' => "Spock vaporizes Rock.", 'scissors' => "Spock smashes Scissors."}
end

class PlayerHand
  include Playable
  attr_accessor :hand
  def choose_hand
    begin
      puts "Please type your choice (rock/paper/scissors/lizard/spock)"
      choice = gets.chomp.downcase
    end until Playable::CHOICES.include?(choice) 
    self.hand = choice
  end
end

class ComputerHand
  include Playable
  attr_accessor :hand
  def choose_hand
    self.hand = Playable::CHOICES.sample
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
    puts "    You chose #{player.hand.capitalize}. \n    The computer chose #{computer.hand.capitalize}."
  end
  
  def compare_hands(*hands)
    winner = nil
    hands.each_with_index do |x, y|
      winning_message = Playable.const_get(x.upcase)[hands[y-1]]
      if winning_message
        puts winning_message
        winner = x
      end
      winner
    end
    if winner == hands[0]
      puts "**You won!**"
    elsif winner == hands[1]
      puts "**You lost!**"
    else
      puts "It's a tie!"
    end
  end
  
  def play_again
    puts "Would you like to play again? (yes/no)"
    answer = gets.chomp.downcase   
    Game.new.play if answer == 'yes'
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
