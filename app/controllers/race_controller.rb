class RaceController < ApplicationController

  get '/race' do
    if is_logged_in?
      @race = Race.all
      erb :'race/index'
    else
      redirect '/'
    end
  end

  get '/race/new' do
    if is_logged_in?
      @locations = Location.all
      erb :'race/new'
    else
      redirect '/'
    end
  end

  post '/race' do
    @user = User.find(session[:user_id])
    @race = @user.race.build(params[:race])
    if params[:race][:race_id] == nil
      city = City.create(params[:city])
      @race.city_id = city.id
    end
    if @race.valid?
      @race.save
      flash[:message] = "Successfully posted race."
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Race was invalid. Please try again."
      redirect '/race/new'
    end
  end

  get '/race/:id' do
    if is_logged_in?
      @race = Race.find(params[:id])
      if current_user == @race.user
        erb :'race/show'
      else
        flash[:message] = "You do not have permission to edit or delete this race."
        redirect "/users/#{@race.user.slug}"
      end
    else
      redirect '/'
    end
  end

  get '/race/:id/edit' do
    if is_logged_in?
      @race = Race.find(params[:id])
      if current_user == @race.user
        erb :'race/edit'
      else
        flash[:message] = "You do not have permission to edit or delete this race."
        redirect "/users/#{@race.user.slug}"
      end
    else
      redirect '/'
    end
  end
  
  post '/race' do
    @user = User.find(session[:user_id])
    @race = @user.race.build(params[:race])
    if params[:race][:city_id] == nil
      city = City.create(params[:city])
      @race.city_id = city.id
    end
    if @race.valid?
      @race.save
      flash[:message] = "Successfully posted race."
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Race was invalid. Please try again."
      redirect '/race/new'
    end
  end

  post '/race/:id' do
    @race = Race.find(params[:id])
    @race.update(type: params[:type], time: params[:time], food: params[:food])
    flash[:message] = "Successfully updated race."
    redirect "/users/#{@race.user.slug}"
  end

  delete '/race/:id' do
    @race = Race.find(params[:id])
    @user = @race.user
    if is_logged_in? && current_user == @race.user
      @race.destroy
      flash[:message] = "Successfully deleted race."
    end
    redirect "/users/#{@user.slug}"
  end
end
