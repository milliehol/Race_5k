class RacesController < ApplicationController

  #displays all races
  get '/races' do
    if is_logged_in?
      @races = Race.all
      erb :'races/index'
    else
      redirect '/'
    end
  end

  #renders new page
  get '/races/new' do
    if is_logged_in?
      @cities = City.all
      erb :'races/new'
    else
      redirect '/'
    end
  end

  #shows races per user if logged in
  get '/races/:id' do
    if is_logged_in?
      @race = Race.find(params[:id])
      if current_user == @race.user
        erb :'races/show'
      else
        flash[:message] = "You do not have permission to edit or delete this race."
        redirect "/users/#{@race.user.slug}"
      end
    else
      redirect '/'
    end
  end

  #renders edit page
  get '/races/:id/edit' do
    if is_logged_in?
      @race = Race.find(params[:id])
      if current_user == @race.user
        erb :'races/edit'
      else
        flash[:message] = "You do not have permission to edit or delete this race."
        redirect "/users/#{@race.user.slug}"
      end
    else
      redirect '/'
    end
  end
  
#adds new race per user
  post '/races' do
    @user = User.find(session[:user_id])
    @race = @user.races.build(params[:race])
    if params[:race][:city_id] == nil
      city = City.create(params[:city])
      @race.city_id = city.id
    end
    if @race.valid?
      @race.save
      flash[:message] = "Successfully added race."
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Race was invalid. Please try again."
      redirect '/races/new'
    end
  end

#updates race if logged in
  post '/races/:id' do
    @race = Race.find(params[:id])
    @race.update(date: params[:date], time: params[:time], food: params[:food], clothing: params[:clothing])
    flash[:message] = "Successfully updated race."
    redirect "/users/#{@race.user.slug}"
  end

#deletes race only if user is logged in
  delete '/races/:id' do
    @race = Race.find(params[:id])
    @user = @race.user
    if is_logged_in? && current_user == @race.user
      @race.destroy
      flash[:message] = "Successfully deleted race."
    end
    redirect "/users/#{@user.slug}"
  end
end
