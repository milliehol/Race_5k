require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
    #sets a session secret for an extra layer of security
      set :session_secret, "secret"
      register Sinatra::Flash
    end

  get '/' do
    if is_logged_in?
      redirect '/races'
    else
      erb :index
    end
  end

  helpers do
   
    #checks if logged in
   def is_logged_in?
     !!current_user
   end

    #keeps track of user that is logged in
   def current_user
     @current_user ||= User.find_by(id: session[:user_id])
   end
 end

end
