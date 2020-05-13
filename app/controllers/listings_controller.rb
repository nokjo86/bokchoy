class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :destroy]
  
  def index
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.profile.listings.create(listing_params)
    if @listing.errors.any?
      render :new
    else
      flash[:success] = "You successfully created a new listing!"
      redirect_to @listing
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to listing_path(@profile.id)
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to profile_path(current_user.profile.id)
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
  params.require(:listing).permit(:title, :description, :price, :picture, :delivery)
  end


end