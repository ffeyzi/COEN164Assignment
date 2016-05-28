require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/daboyz.db")

class Student
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :bio, Text
  property :age, Integer
  property :born, Date
  
  def released_on=date
    super Date.strptime(date, '%m/%d/%Y')
  end
end

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

DataMapper.finalize

get '/students' do
  @students = Student.all
  erb :students
end

get '/students/new' do
  @student = Student.new
  erb :new_student
end

get '/students/:id' do
  @student = Student.get(params[:id])
  erb :show_student
end

get '/students/:id/edit' do
  @student = Student.get(params[:id])
  erb :edit_student
end

post '/students' do  
  student = Student.create(params[:student])
  redirect to("/students/#{student.id}")
end

put '/students/:id' do
  student = Student.get(params[:id])
  student.update(params[:student])
  redirect to("/students/#{student.id}")
end

delete '/students/:id' do
  Student.get(params[:id]).destroy
  redirect to('/students')
end
