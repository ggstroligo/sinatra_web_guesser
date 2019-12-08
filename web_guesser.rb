require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(0..100)

def check_guess(guess)
  return "Way too high!" if guess - settings.secret_number >= 5
  return "Too high!" if guess > settings.secret_number 
  return "Way too low!"  if guess - settings.secret_number <= 5 
  return "Too low!"  if guess < settings.secret_number 
  "You're God damn right!"
end


get '/' do
  guess = params["guess"].to_i
  message = 

  erb :index, :locals => { 
    :secret_number => settings.secret_number, 
    :guess => params[:guess],
    :message => check_guess(guess)
  }
end
