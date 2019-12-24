require 'byebug'
class OrdersController < ApplicationController

# index
get '/orders' do
  redirect_if_not_logged_in
    @user = User.find_by(:id => session[:user_id]) 
    if @user.orders
      @show_orders = @user.orders.all
      erb :'order/index'
    else 
      redirect '/orders/new'
    end
end

 # new
 get "/orders/new" do
    redirect_if_not_logged_in
      @order = Order.new
      erb :'/order/new'
  end

  # create
  post "/orders" do
      if params[:customer_name] == "" || params[:item] == "" || params[:amount] == "" || params[:pick_up_date] == ""
        redirect to "/orders/new"
      else
        #@order = current_user.orders.create
        @order = Order.new(order_params)
        @order.user_id = session[:user_id]
        @order.save
        current_user.orders << @order
        redirect to "/orders"
      end
  end


  # show
  get "/orders/:id" do
    redirect_if_not_logged_in
      @user = User.find_by(:id => session[:user_id])
      @order = Order.find_by_id(params[:id])
      erb :'/order/show'
  end


  #edit
  get '/orders/:id/edit' do
    redirect_if_not_logged_in
      @show_orders = Order.find(params[:id])
      if @show_orders.user == current_user
        erb :'/order/edit'
      else
        redirect to '/orders'
      end
  end


    private 

      def order_params
        {:customer_name => params[:customer_name], :item => params[:item], 
          :amount => params[:amount], :pick_up_date => params[:pick_up_date]}
      end
  
end