class OrdersController < ApplicationController

# index
get '/orders' do
  redirect_if_not_logged_in
    @user = current_user
      @orders = @user.orders.all
      erb :'order/index'
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
        @order = current_user.orders.create(order_params)
        redirect to "/orders"
      end
  end


  # show
  get "/orders/:id" do
    redirect_if_not_logged_in
      @user = current_user
      @order = Order.find_by_id(params[:id])
      erb :'/order/show'
  end


  #edit
  get '/orders/:id/edit' do
    redirect_if_not_logged_in
      @order = Order.find(params[:id])
      if @order.user == current_user
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