class CartItemsController < ApplicationController
before_action :authenticate_user!
before_action :set_profile
before_action :check_existed?, except: [:create, :destroy]

  def create
    if check_existed? == nil
      CartItem.create(item_params.merge(cart_id: @profile.cart.id))
    else
      @existing_item.quantity += item_params[:quantity].to_i
      @existing_item.save
    end
    check_existed?
    flash[:bought] = "#{ActionController::Base.helpers.pluralize(@existing_item.quantity, 'item')} in basket"
    redirect_to request.referer
  end

  def update
    check_existed?
    @existing_item.update(quantity: item_params[:quantity])
    redirect_to request.referer
  end

  def destroy
    relationship = CartItem.find(params[:id])
    relationship.destroy
    redirect_to request.referer
  end

  private

  def item_params
    params.require(:cart_item).permit(:listing_id, :quantity)
  end

  def check_existed?
    @existing_item = CartItem.find_by(cart_id: @profile.cart.id, listing_id: item_params[:listing_id])
  end
end
