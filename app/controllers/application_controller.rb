require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, SecureRandom.base64
  end

  get '/' do
    erb :index
  end

  def logged_in?
    if session[:id] != nil
      true
    else
      false
    end
  end
end
