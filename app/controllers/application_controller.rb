require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
    #sets a session secret for an extra layer of security
      set :session_secret, "secret"
      use Rack::Flash, sweep: true
    end

  get '/' do
    if is_logged_in?
      redirect '/races'
    else
      erb :index
    end
  end

  helpers do

   def is_logged_in?
     !!current_user
   end

   def current_user
     @current_user ||= User.find_by(id: session[:user_id])
   end
 end

end
