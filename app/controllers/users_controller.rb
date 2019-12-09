require 'byebug'
class UserController < ApplicationController

    get '/signup' do
        if !logged_in?
          erb :'user/signup'
        else
          redirect to '/orders'
        end
      end

    post '/signup' do 
      @user = User.find_by(:username => params[:username])
        if @user
          redirect to '/login'
        else
          @user = User.new(user_params)
            if @user.save
              session[:user_id] = @user.id
              redirect to '/orders'
            else
              redirect to '/signup'
            end
          end
        end

      get '/login' do
        if !logged_in?
          erb :'user/login'
        else
          redirect to '/orders'
        end
      end

      post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/orders"
        else
          redirect '/signup'
        end
      end

      get '/logout' do
        if logged_in?
          session.destroy
          redirect to '/login'
        else
          redirect to '/'
        end
      end

      private

        def user_params
            {:username => params[:username], :password => params[:password]}
        end

end