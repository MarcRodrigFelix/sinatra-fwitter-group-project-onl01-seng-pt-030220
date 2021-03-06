class UsersController < ApplicationController

  get '/' do
    @users = User.all
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    end
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect "/login"
    else
      redirect '/login'
    end
  end

  post '/logout' do
    if logged_in?
      redirect '/logout'
    else
      redirect '/login'
    end
  end

end
