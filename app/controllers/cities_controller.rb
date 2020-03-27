class CitiesController < ApplicationController

  get '/cities' do
    if is_logged_in?
      @cities = City.all
      erb :'cities/index'
    else
      redirect '/'
    end
  end

  get '/cities/:slug' do
    if is_logged_in?
      @city = City.find_by_slug(params[:slug])
      erb :'cities/show'
    else
      redirect '/'
    end
  end
end