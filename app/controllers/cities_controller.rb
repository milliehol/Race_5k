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
  
  #renders new form for creating a new city
   get '/cities/new' do
    if is_logged_in?
      @cities = City.all
      erb :'cities/new'
    else
      redirect '/'
    end
  end
  
  #saves new city if logged in and valid city according to model
  post '/cities' do
    if is_logged_in?
      
      @city = City.create(params[:city])
      if @city.valid?
        @city.save
        flash[:message] = "Successfully added city."
        redirect "/cities"
      else
        flash[:error] = "City was invalid. Please try again."
        redirect '/cities/new'
      end
      
    else
       redirect '/'
    end
      
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
