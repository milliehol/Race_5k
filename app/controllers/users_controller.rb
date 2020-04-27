class UsersController < ApplicationController

  #renders login form
  get '/login' do
    if is_logged_in?
      redirect '/races'
    else
      erb :'users/login'
    end
  end

  #receives the data(params) from the login form
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome back #{@user.name}."
      redirect '/races'
    else
      flash[:error] = "Invalid username or password."
      redirect '/login'
    end
  end

  #clears session hash
  get '/logout' do
    if is_logged_in?
      session.clear
    end
    redirect '/'
  end

  #sign up
  get '/signup' do
    if is_logged_in?
      redirect '/races'
    else
      erb :'users/new'
    end
  end

  #post sign up route that receives input data from user
  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/races'
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect '/signup'
    end
  end

  #users show route, shows "My races" when click on menu item
  get '/users/:slug' do
    if is_logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    else
      redirect '/'
    end
  end

end
