require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'app/views'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "wfm_market"
  end

  # update
  patch "/orders/:id" do
    @order = Order.find_by(:id => params[:id])
    @order.update(params[:order])
    redirect to "/orders/all"
  end

  # delete
  delete '/delete/:id' do
    redirect_if_not_logged_in
      @order = Order.find_by(:id => params[:id])
      if @order.user == current_user
        @order.destroy
        redirect to "/orders"
      else 
        redirect to "/orders"
      end
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

  def redirect_if_not_logged_in
    if !logged_in?
      redirect to "/login"
    end
  end

end

end