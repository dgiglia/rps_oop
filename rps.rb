class PlayerHand
  attr_accessor :hand
  def choose_hand
    begin
      puts "Please type your choice."
      choice = gets.chomp.downcase
    end until Game::CHOICES.include?(choice) 
    self.hand = choice
  end
end

class ComputerHand
  attr_accessor :hand
  def choose_hand
    self.hand = Game::CHOICES.sample
  end
end

class Game  
  CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  ROCK = {'lizard' => "Rock crushes lizard.", 'scissors' => "Rock crushes scissors."}
  PAPER = {'rock' => "Paper covers rock.", 'spock' => "Paper disproves Spock."}
  SCISSORS = {'paper' => "Scissors cut paper.", 'lizard' => "Scissors decapitate Lizard."}
  LIZARD = {'paper' => "Lizard eats Paper.", 'spock' => "Lizard poisons Spock."}
  SPOCK = {'rock' => "Spock vaporizes Rock.", 'scissors' => "Spock smashes Scissors."}
  
  attr_accessor :player, :computer

  def initialize 
    @player = PlayerHand.new
    @computer = ComputerHand.new
  end
  
  def greeting
    puts "Welcome to Rock-Paper-Scissors-Lizard-Spock"
  end
  
  def display_hands
    puts "    You chose #{player.hand.capitalize}. \n    The computer chose #{computer.hand.capitalize}."
  end
  
  def compare_hands(*hands)
    winner = nil
    hands.each_with_index do |hand, index|
      winning_message = Game.const_get(hand.upcase)[hands[index-1]]
      if winning_message
        puts winning_message
        winner = hand
      end
    end
    winner
  end  
  
  def display_winner
    if player == computer
      puts "It's a tie!"
    end  
    winner = compare_hands(player, computer)    
    case winner
    when player
      puts "**You won!**"
    when computer
      puts "**You lost!**"
    end
  end
  
  def play_again
    puts "Would you like to play again? (yes/no)"
    answer = gets.chomp.downcase   
    false if answer != 'yes'
  end
  
  def play
    system "clear"
    greeting
    player.choose_hand
    computer.choose_hand
    display_hands
    compare_hands(player.hand, computer.hand)
    display_winner
  end
end

game = Game.new

begin
  game.play
end while game.play_again
puts "Thanks For Playing."