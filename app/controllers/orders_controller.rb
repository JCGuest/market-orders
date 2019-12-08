require 'byebug'
class OrdersController < ApplicationController

get '/orders' do
    if logged_in? 
      @user = User.find_by(:id => session[:user_id]) 
      # order = Order.find_by(user_id: session[:user_id])
      if @user.orders
        @show_orders = @user.orders.all
      erb :'order/show'
      else 
        redirect '/orders/new'
      end
    else
      redirect to "/login"
    end 
end

 # new
 get "/orders/new" do
    if logged_in?
      @order = Order.new
      erb :'/order/new'
    else
      redirect to "/login"
    end
  end

  # create
  post "/orders" do
    if logged_in?
      if params[:customer_name] == "" || params[:item] == "" || params[:amount] == "" || params[:pick_up_date] == ""
        redirect to "/orders/new" , locals: {message: "Something went wrong. Please submit order again"}
      else
        @order = Order.new(order_params)
        @order.user_id = session[:user_id]
        @order.save
        current_user.orders << @order
        redirect to "/orders/all"
      end
    else
      redirect to "/login", locals: [message: "Please log in before submitting new orders."]
    end
  end


  # show all
  get "/orders/all" do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      @show_orders = @user.orders
      erb :'/order/show'
    else
      redirect to "/login"
    end
  end

  get "/orders/:id" do 
    if logged_in?
      @order = Order.find_by(:id => params[:id])
      erb :'order/by_id'
    else
      redirect to "/login"
    end
  end

  #edit
  get '/orders/:id/edit' do
    if logged_in?
      @show_orders = Order.find(params[:id])
      if @show_orders.user == current_user
      erb :'/order/edit'
      else
        redirect to 'orders/all'
    end
    else
      redirect to "/login"
    end
  end


    private 

      def order_params
        {:customer_name => params[:customer_name], :item => params[:item], 
          :amount => params[:amount], :pick_up_date => params[:pick_up_date]}
      end
  
end