class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect "/login"
    end
    @tweets = Tweet.all
    @user = current_user
  binding.pry
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    end
      erb :'/tweets/new'
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.new(:content => params[:content])
      @tweet.user = current_user
        if @tweet.save
          redirect '/tweets'
        end
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
  end

end
