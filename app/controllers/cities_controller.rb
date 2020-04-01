class CitiesController < ApplicationController

#displays cities available for 5k races if logged in
  get '/cities' do
    if is_logged_in?
      @cities = City.all
      erb :'cities/index'
    else
      redirect '/'
    end
  end
  
   get '/cities/new' do
    if is_logged_in?
      @cities = City.all
      erb :'cities/new'
    else
      redirect '/'
    end
  end
  
  post '/cities' do
    @user = User.find(session[:user_id])
    @city = @user.cities.build(params[:city])
    if @city.valid?
      @city.save
      flash[:message] = "Successfully added race."
      redirect "/cities"
    else
      flash[:message] = "Race was invalid. Please try again."
      redirect '/cities/new'
    end
  end
  
#deletes race only if user is logged in
  delete '/cities/:id' do
    @city = City.find(params[:id])
    @user = @city.user
    if is_logged_in? && current_user == @city.user
      @city.destroy
      flash[:message] = "Successfully deleted city."
    end
    redirect "/cities"
  end

#displays all races by city if logged in
  get '/cities/:slug' do
    if is_logged_in?
     @city = City.find_by_slug(params[:slug])
      erb :'cities/show'
    else
      redirect '/'
    end
  end
  
end
