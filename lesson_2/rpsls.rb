VALID_CHOICES = %w(rock paper scissors lizard spock)
WIN_VALS = { 'rock' => ['scissors', 'lizard'],
             'paper' => ['rock', 'Spock'],
             'scissors' => ['paper', 'lizard'],
             'lizard' => ['paper', 'Spock'],
             'Spock' => ['rock', 'scissors']}
COUNT_TO_WIN = 3
RULES = <<-MSG
  Scissors cuts paper,
  paper covers rock,
  rock crushes lizard,
  lizard poisons Spock,
  Spock smashes scissors,
  scissors decapitates lizard,
  lizard eats paper,
  paper disproves Spock,
  Spock vaporizes rock,
  rock crushes scissors.
MSG

player_score = []
comp_score = []

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_greeting
  prompt("Welcome to the Rock, Paper, Scissors, Lizard, Spock Game!")
  prompt("The First player with #{COUNT_TO_WIN} wins takes the match. Good luck!")
end

def display_rules
  loop do
    prompt("Would you like to see the rules? (Type 'Y' for yes, 'N' for no.)")
    answer = gets.chomp
    system 'clear'
    if answer.downcase == 'y' || answer.downcase == 'yes'
      puts RULES
      break
    elsif answer.downcase == 'n' || answer.downcase == 'no'
      break
    else
      prompt("That's not a valid choice.")
    end
  end
end

def get_user_choice
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}.
          Type 'r' for rock, 'p' for paper, 's' for scissors,
          'l' for lizard, or 'S' for Spock:")
    user_choice_abbrev = gets.chomp

    return 'rock' if user_choice_abbrev == 'r'
    return 'paper' if user_choice_abbrev == 'p'
    return 'scissors' if user_choice_abbrev == 's'
    return 'lizard' if user_choice_abbrev == 'l'
    if user_choice_abbrev == 'S'
      return 'Spock'
    else
      prompt("That's not a valid choice.")
    end
  end
end

def win?(player, computer, win_vals)
  win_vals[player].include?(computer)
end


def display_results(player, computer, win_vals, player_score, comp_score)
  prompt("You chose: #{player}; Computer chose: #{computer}.")
  if win?(player, computer, win_vals)
    prompt("You won!")
    add_player_score(player_score)
  elsif player == computer
    prompt("It's a tie!")
  else
    prompt("Computer won!")
    add_computer_score(comp_score)
  end
end

def add_player_score(player_score)
  player_score << 'win'
end

def add_computer_score(comp_score)
  comp_score << 'win'
end

def display_score(player, comp)
  prompt("Current score is Player: #{player.length}, Computer: #{comp.length}.")

  if player.length >= COUNT_TO_WIN
    prompt("You've scored #{COUNT_TO_WIN} times.
          You've won the match! Congratulations!")
  elsif comp.length >= COUNT_TO_WIN
    prompt("The computer has scored #{COUNT_TO_WIN} times.
          You've lost the match!")
  end
end

def play_again?
  loop do
    prompt("Do you want to play again?")
    prompt("Type 'Y' for yes or 'N' for no:")
    answer = gets.chomp
    system 'clear'
    if answer.downcase == 'y' || answer.downcase == 'yes'
      return answer
    elsif answer.downcase == 'n' || answer.downcase == 'no'
      break
    else
      prompt("Thats's not a valid choice.")
    end
  end
end

def display_goodbye
  prompt("Thank you for playing! Goodbye.")
end

system 'clear'
display_greeting
display_rules

loop do 
  user_choice = get_user_choice
  comp_choice = VALID_CHOICES.sample
  system 'clear'
  display_results(user_choice, comp_choice, WIN_VALS, player_score, comp_score)
  display_score(player_score, comp_score)
  if player_score.length == COUNT_TO_WIN || comp_score.length == COUNT_TO_WIN
    player_score.clear
    comp_score.clear
    break unless play_again?
  end
end

display_goodbye
