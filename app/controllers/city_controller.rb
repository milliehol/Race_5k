class CityController < ApplicationController

  get '/city' do
    if is_logged_in?
      @city = City.all
      erb :'city/index'
    else
      redirect '/'
    end
  end

  get '/city/:slug' do
    if is_logged_in?
      @city = City.find_by_slug(params[:slug])
      erb :'city/show'
    else
      redirect '/'
    end
  end
end
