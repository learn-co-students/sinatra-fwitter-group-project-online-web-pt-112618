class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :"/users/create_user"
  end

  post '/signup' do
    #we use "new" because we want to save only user has name, email and passwrod
    @user = User.new(params)
    if !User.where({email: @user.email}).empty?
      redirect "/login"
    end

    if
      @user.save && !@user.username.empty? && !@user.email.empty?
      #going to tweets page (login at the same time
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    #authenticate communicate with bcript
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      #why not erb? 1) post's job is to create user, not render 2) erb can access to instance variable but in this case, carrying instance variable is not necessary
      redirect "/tweets"
    elsif @user
      !@user.authenticate(params[:password])
      redirect "/login"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end

  #Show page
  get '/users/:slug' do
    slug = params[:slug]
    @user.slug
    @users = User.all
    erb :"/users/show"
  end


end
