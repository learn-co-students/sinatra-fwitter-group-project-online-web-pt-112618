class UsersController < ApplicationController

  get '/signup' do
    if session[:id] == nil
      erb :'/users/signup'
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    if session[:id] == nil
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    if session[:id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  post '/signup' do
    data = params.map { |key, value| value}

    if !data.include?("")
      user = User.create(params)
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
end
