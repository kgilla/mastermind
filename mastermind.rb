# Greeting template
# 2.times {puts "#"*80}
# puts "#"*20 + " "*40 + "#"*20 
# puts "#"*20 + " "*9 + "Welcome To Mastermind!" + " "*9 + "#"*20
# puts "#"*20 + " "*40 + "#"*20 
# 2.times {puts "#"*80}

# puts "\n Mastermind is a logic based game where you try to guess the secret key combination before running out of moves! Use logic and your powers of deduction to figure out the combination before its too late!"

# 4.times {puts " "}

def generate_key 
  array = []
  4.times {array.push(rand(1...6).to_s)}
  return array
end

def get_guess 
  puts "Guess what the key is by giving four numbers 1 - 6!"
  guess = gets.chomp.split("")
  if guess.length != 4
    puts "FOUR NUMBERS BETWEEN 1-6!"
    get_guess()
  end
  return guess
end

def show_correct (current_guess, secret_key)
  correct_count = 0
  temp_key = secret_key
  for i in 0..3
    if current_guess[i] == secret_key[i]
      temp_key[i] = "F"
      correct_count += 1
    end
  end; hint_count = show_hints(current_guess, temp_key)
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

def make_round_array (hint_array, current_guess)
  arr = hint_array + current_guess
  return arr
end

def round_data (secret_key)
  current_guess = get_guess()
  correct_hint = show_correct(current_guess, secret_key)
  hint_array = make_hint_array(correct_hint)
  round_array = make_round_array(hint_array, current_guess)
  return round_array
end

def print_row (hint_array, current_guess)
  puts "\n"*2
  puts " "*5 + "Hint Key" + " "*5 + "Your Guess"
  puts " "*5 + "#{hint_array[0]} #{hint_array[1]} #{hint_array[2]} #{hint_array[3]}" + " "*7 + "#{current_guess[0]} #{current_guess[1]} #{current_guess[2]} #{current_guess[3]}"
end

secret_key = generate_key()
array = round_data(secret_key)
print array
# current_guess = get_guess()
# correct_hint = show_correct(current_guess, secret_key)
# # temp_key = temp_correct.pop; 
# # correct_pegs = temp_correct.join("")
# # hint_pegs = show_hints(temp_correct)
# hint_array = make_hint_array(correct_hint)
# round_array = make_round_array(hint_array, current_guess)
# # print_row(hint_array, current_guess)


# [[1,2,3,4,5,6,7,8]]

