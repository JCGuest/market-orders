require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'app/views'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "wfm_market"
  end

  #edit
  patch "/orders/:id" do
    @order = Order.find_by(:id => params[:id])
    @order.update(params[:order])
    redirect to "/orders/all"
  end

  #destroy
  delete '/delete/:id' do
    Order.destroy(params[:id])
    redirect to "/orders"
  end

  get '/' do 
    erb :home
  end

  get '/error' do 
    erb :error
  end


  helpers do 

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end

end