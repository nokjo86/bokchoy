class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_profile, only: [:create, :destroy]
  authorize_resource

  def index
    ## If user using the search title function
    if params[:search]
      ## Searches listings table and selects listing if listing matches the search keyword and is not closed
      ## Includes image record for the selected record
      @listings = Listing.with_attached_image.where("lower(title) LIKE ?","%#{params[:search].downcase}%").where(closed: false)
      check_nil?
    ## If there is a geolocation stored in the cookie
    elsif cookies[:lat_lon]
      ## Convert cookies back to an array
      user_location = JSON.parse cookies[:lat_lon]
      ## Searches any user near the user_location and only return profile id
      nearby_user = Profile.near(user_location, 20).reorder('').pluck(:id)
      ## Searches and returns listings if profile id matches the array of id
      ## Includes image record for the selected record
      @listings = Listing.with_attached_image.where(profile_id: nearby_user, closed: false)
      check_nil?
      ## if there is geolocation stored and user used the filter function
      if params[:filter]
        ## alter @listings with filter
        @listings = @listings.where(product_id: params[:filter], closed: false)
        check_nil?
      end
    ## User uses the filter function without a stored location
    elsif params[:filter]
      ## Searches 
      ## Includes image record for the selected record
     @listings = Listing.with_attached_image.where(product_id: params[:filter], closed: false)
        check_nil?
    else 
      ## Inludes image record for the selected record
      @listings = Listing.with_attached_image.where(closed: false)
    end
  end

  def show
  end

  def new
    profile_blank?
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
    if @listing.carts.length == 0
      @listing.destroy
      flash[:success] = "Listing deleted successfully" 
    else 
      @listing.closed = true
      if @listing.save
        flash[:alert] = "Listing cannot be deleted but is now closed" 
      end
    end
    redirect_to profile_path(@profile.id)

  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :image, :delivery, :product_id)
  end

  def check_nil?
    if @listings.length < 1
      flash.now[:alert] = "No matching result found"
      @listings = Listing.with_attached_image.where(closed: false)
    end
  end
end