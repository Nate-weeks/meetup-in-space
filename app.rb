require 'sinatra'
require_relative 'config/application'
require 'sinatra/activerecord'
require 'pry'


set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all
  erb :'meetups/index'
end

post '/meetups' do

  @error = ""
if current_user
   new_meetup = Meetup.create(name: params[:name], location: params[:location], description: params[:description], creator_id: current_user.username)
 else
   @error = "you aren't signed in"
   @meetups = Meetup.all
   erb :'meetups/index'
end

  if new_meetup.errors
     @form_error = new_meetup.errors.full_messages[0]
     @meetups= Meetup.all
     erb :'meetups/index'
   else
     new_meetup
   redirect '/'
 end
end

get '/meetups/:id' do
  @meetup = Meetup.find_by(id: params[:id])
  erb :'meetups/show'
end
