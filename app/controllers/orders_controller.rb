class OrdersController < ApplicationController
before_action :authenticate_user!
before_action :set_profile
  def index
    @orders = @profile.orders
  end

  def show
    @order = Order.find(params[:id])
    ## Find an array of order_items with the corresponding listing details and the profile/user information linked to listing. Preloading associated tables in this step can minimize the query call when accessing the listing title and listing owner username in the view model.
    @order_items = OrderItem.includes(listing: {profile: :user}).where(order_id: params[:id])
  end
end
