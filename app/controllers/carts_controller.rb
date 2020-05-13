class CartsController < ApplicationController
before_action :set_profile, only: [:show]

  def show
    @cart = @profile.cart.listings
  end
end
