require 'sinatra'
require 'slim'
require 'sass'
require_relative './student'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/daboyz.db")
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

get('/styles.css'){ scss :styles }

get '/' do
  erb :home
end

get '/about' do
  @title = "All About This Website"
  erb :about
end

get '/contact' do
  erb :contact
end

not_found do
  erb :not_found
end

#Logic helped and provided by slide 20 on 7-2. 

get '/login' do
  erb :login
end

post '/login' do
  if params[:username] == settings.username &&
    params[:password] == settings.password

    session[:admin] = true
    redirect to ('/students')
  else
    erb :login
  end
end 

get '/logout' do
  session.clear
  redirect to ('/login')
end

#Again all the logic above was provided by the slides on 7-2
