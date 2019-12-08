require 'byebug'
class OrdersController < ApplicationController

  # patch "/orders/:id" do
  #   @order = Order.find_by(:id => params[:id])
  #   @order.update(params[:order])
  #   redirect to "/orders/all"
  # end


get '/orders' do 
    @user = User.find_by(:id => session[:user_id]) 
    # order = Order.find_by(user_id: session[:user_id])
    if @user.orders
      @show_orders = @user.orders.all
    erb :'order/show'
    else 
      redirect '/orders/new'
    end
end

 # new
 get "/orders/new" do
    @order = Order.new
    erb :'/order/new'
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
    @user = User.find_by(:id => session[:user_id])
    @show_orders = @user.orders
    erb :'/order/show'
  end

  get "/orders/:id" do 
    @order = Order.find_by(:id => params[:id])
    erb :'order/by_id'
  end

  #edit
  get '/orders/:id/edit' do 
    @show_orders = Order.find(params[:id])
    erb :'/order/edit'
  end

  # #destroy
  # delete '/delete/:id' do
  #   Order.destroy(params[:id])
  #   redirect to "/orders"
  # end

    private 

      def order_params
        {:customer_name => params[:customer_name], :item => params[:item], 
          :amount => params[:amount], :pick_up_date => params[:pick_up_date]}
      end
  
end