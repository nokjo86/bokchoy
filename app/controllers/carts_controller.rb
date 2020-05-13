class CartsController < ApplicationController
before_action :authenticate_user!
before_action :set_profile, only: [:show]

  def show
    @cart = @profile.cart.listings.order(:title)
  end

end