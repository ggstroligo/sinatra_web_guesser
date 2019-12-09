require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(0..100)
@@guesses_remaining = 6

STATUSES = {
  :no_guess => { correct: false, message: "Do your guess!", bg_color: "gray" },
  :way_high => { correct: false, message: "Way too high!", bg_color: "red" },
  :high     => { correct: false, message: "Too high!", bg_color: "ff9696" },
  :way_low  => { correct: false, message: "Way too low!", bg_color: "red" },
  :low      => { correct: false, message: "Too low!", bg_color: "ff9696" },
  :correct  => { correct: true, message: "You're God damn right!", bg_color: "green" }
}
def reset_game
  @@secret_number = rand(0..100)
  @@guesses_remaining = 6
end

def guess_evaluate(guess)
  return :no_guess unless guess
  return :way_high if guess - @@secret_number >= 5
  return :high     if guess > @@secret_number 
  return :way_low  if guess - @@secret_number <= -5 
  return :low      if guess < @@secret_number 
  return :correct
end

get '/' do
  @@guesses_remaining -= 1
  guess           = params[:guess].to_i
  cheated         = !!params[:cheat]
  evaluated_guess = guess_evaluate(guess)
  status          = STATUSES[evaluated_guess]
  reset_game if evaluated_guess == :correct || @@guesses_remaining == 0 

  erb :index, :locals => { 
    :secret_number => @@secret_number, 
    :guess => guess,
    :status => status,
    :cheated => cheated,
    :attempts => @@guesses_remaining
  }
end
