def get_secret_code
  secret_code = ""
  puts "Make a code consisting of 4 numbers (1-6)"
  secret_code = gets.chomp.split("")
  if secret_code.length != 4
    get_secret_code()
  end
  return secret_code
end

def computer_guess
  array = []
    4.times {array.push(rand(1...6).to_s)}
    return array
end

def get_hint_array
  hint_array = ""
  puts "Give a 'B' for each correct number in the correct space"
  puts "Give a 'W' for each correct number in the wrong space"
  hint_array = gets.chomp.upcase.split("")
  while hint_array.length < 4
    hint_array.push("*")
  end
  return hint_array
end

last_guess = computer_guess()
print get_hint_array()