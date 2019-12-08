require 'sinatra'
require 'sinatra/reloader'


SECRET_NUMBER = rand(0..100)

get '/' do
  erb :index, :locals => { :secret_number => SECRET_NUMBER }
end
