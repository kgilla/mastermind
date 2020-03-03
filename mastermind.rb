class PlayerGuess
  attr_accessor :secret_key, :rounds_total, :round_count
  
  def initialize
    @secret_key = generate_key()
    @rounds_total = []
    @round_count = 0
  end

  #main function
  def round_data (new_game)
    temp_key = new_game.secret_key.slice(0, 4)
    current_guess = get_guess()
    correct_hint = show_correct(current_guess, temp_key)
    hint_array = make_hint_array(correct_hint)
    single_round = make_arr(hint_array, current_guess)
    return single_round
  end

  def generate_key 
    array = []
    4.times {array.push(rand(1...6).to_s)}
    return array
  end
  
  def get_guess 
    puts " "
    puts "\n Guess what the key is by giving four numbers 1 - 6!"
    guess = gets.chomp.split("")
    if guess.length != 4
      puts "FOUR NUMBERS BETWEEN 1-6!"
      get_guess()
    end
    return guess
  end
  
  def show_correct (current_guess, temp_key)
    correct_count = 0; 
    for i in 0..3
      if current_guess[i] == temp_key[i]
        temp_key[i] = "F"
        correct_count += 1
      end
    end 
    hint_count = show_hints(current_guess, temp_key)
    return correct_count, hint_count
  end
  
  def show_hints (current_guess, temp_key)
    hint_count = 0 
    for i in 0..3
      for t in 0..3
        if temp_key[i] == current_guess[t]
          hint_count += 1
          temp_key[i] = "F"
        end
      end
    end
    return hint_count
  end
  
  def make_hint_array (correct_hint)
    hint_array = []
    correct_hint[0].to_i.times {hint_array.unshift("B")}
    correct_hint[1].to_i.times {hint_array.unshift("W")}
    while hint_array.length < 4
      hint_array.push("*")
    end
    return hint_array
  end 
  
  def make_arr (hint_array, current_guess)
    single_round = hint_array + current_guess
    return single_round
  end

  def check_winner(single_round)
    hint_count = 0
    single_round.each do |hint|
      if hint == "B"
        hint_count += 1
        if hint_count == 4
          win = true
          game_over(win)
        end
      end
    end
  end

  def game_over (win = false)
    if win == true
      puts "\nCongratulations! You are a true Mastermind!"
      play_again()
    else
      puts "\nLooks like you lost..... Bummer."
      play_again()
    end
  end
end

def intro
  2.times {puts "#"*80}
  puts "#"*20 + " "*40 + "#"*20 
  puts "#"*20 + " "*9 + "Welcome To Mastermind!" + " "*9 + "#"*20
  puts "#"*20 + " "*40 + "#"*20 
  2.times {puts "#"*80}
  title_screen()
end

def title_screen
  puts "\nChoose A Mode!"
  puts "1) Computer is the Code Maker"
  puts "2) You are the Code Maker"
  puts "3) Rules"
  puts "4) Quit Game"
  answer = gets.chomp
  if answer == "1"
    player_guess_ng()
  elsif answer == "2"
    puts "not yet done"
  elsif answer == "3"
    show_rules()
  else
    exit
  end
end

def show_rules
  puts "\n Mastermind is a logic based game where you try to guess the secret key\n combination before running out of moves! Use logic and your powers of\n deduction to figure out the combination before its too late!"
  puts "\n Rules"
  puts "\n The code maker makes a secret code that needs to be cracked in 10 moves or less.\n Each round, the code breaker must guess what the secret code must be.\n The code maker then gives the code breaker a Hint Key which shows the following:"
  puts "1) Shows a 'B' for each correct number in the correct place\n2) Shows a 'W' for every correct number that is not in it's correct space"
  puts "\n Have Fun and Good Luck!"
  sleep(10)
  title_screen()
end

def print_row (arr)
  puts "\n"*2
  puts " "*15 + "Hint Key" + " "*10 + "Your Guess"
  round = 0
  arr.each do |arr|
    round += 1
  puts "Round: #{round} =>" + " "*2 + "#{arr[0]} | #{arr[1]} | #{arr[2]} | #{arr[3]}" + " "*5 + "#{arr[4]} | #{arr[5]} | #{arr[6]} | #{arr[7]}"
  end
end

def play_again
  puts "Want to play again? (Y/N)"
  answer = gets.chomp.upcase
  if answer.length != 1
    play_again()
  end
  if answer == "Y"
    player_guess_ng()
  else 
    intro()
    title_screen()
  end
end

def player_guess_ng
  puts "\n Can you crack the code in time? ....."
  new_game = PlayerGuess.new
  while new_game.round_count < 10
    single_round = new_game.round_data(new_game)
    new_game.rounds_total.push(single_round)
    print_row(new_game.rounds_total)
    new_game.check_winner(single_round)
    if new_game.round_count == 9
      new_game.game_over()
    end
    new_game.round_count += 1
  end
end


intro()