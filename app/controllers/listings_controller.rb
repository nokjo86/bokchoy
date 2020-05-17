class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_profile, only: [:create, :destroy]
  authorize_resource

  def index
    @listings = Listing.where(closed: false)
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = @profile.listings.create(listing_params)
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
      redirect_to listing_path(@listing.id)
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to profile_path(@profile.id)
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
  params.require(:listing).permit(:title, :description, :price, :picture, :delivery)
  end
end