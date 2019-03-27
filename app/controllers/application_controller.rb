require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      #find return "error" and find_by returns "nill"
      #it is better to return nil just thrown error
      # ||= memory saver. First time when @current_user calls, it hits the right side of ||=. Next time it just call @current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end


  end

end
