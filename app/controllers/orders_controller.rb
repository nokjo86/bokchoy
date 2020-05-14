class OrdersController < ApplicationController
before_action :authenticate_user!
before_action :set_profile
  def index
    @orders = @profile.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: params[:id])
  end
end
