class TweetsController < ApplicationController
#Two controller actions

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  #Create tweet form
  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = current_user.tweets.create(params)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  #Show Tweet (include edit link here)
  get '/tweets/:id' do
    #find_by_id returns nil, but find(id: params[:id] throw eror)
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && !@tweet.nil? && @tweet.user_id == current_user.id
      erb :"/tweets/show_tweet"
    elsif @tweet.nil?
      redirect "/tweets"
    else
      redirect "/login"
    end

  end

  #Edit Tweet
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet && @tweet.user_id == current_user.id

      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  #Delete Tweet
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      #if there is no tweet created(no tweet id)
      #if tweet are not created, it returns "no method error"
      #binding.pry
      if @tweet && @tweet.user == current_user
         @tweet.delete
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

end
