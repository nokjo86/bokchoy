class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_profile, except: :show

  def show
    @profile = Profile.find(params[:id])
    @listings = Listing.where(profile_id: params[:id])
  end

  def edit

  end

  def update
    profile_params[:location] == "" ? search_code = Geocoder.search(profile_params[:address]) : search_code = Geocoder.search(profile_params[:location]) 
    geocode = search_code.first.coordinates
    geocode_hash = {geo_lat: sprintf("%.4f",geocode.first).to_f, geo_long: sprintf("%.4f",geocode.last).to_f}
    if @profile.update(profile_params.merge(geocode_hash).except(:location))
      redirect_to profile_path(@profile.id)
    else
      render :edit
    end
  end

  private
  def location_params
    :location_param
  end

  def profile_params
    params.require(:profile).permit(:location, :first_name, :last_name, :address)
  end

  def set_profile
    @profile = current_user.profile
  end
  
end
