class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_profile, except: :show

  def show
    ## Loads user profile from the profiles table with its associated listings and pre-load all image records associated to the listing
    @profile = Profile.includes(listings: {image_attachment: :blob}).find(params[:id])
  end

  def edit

  end

  def update
    rawdata = Geocoder.search([profile_params[:address_line1],profile_params[:address_line2],profile_params[:suburb],profile_params[:state],profile_params[:postcode]].join(','))
    if rawdata == []
      flash[:alert] = "Oop! We could not locate this address. Please re-enter"
      redirect_to request.referer
    elsif
      @profile.update(profile_params)
      session[:back_path] == nil ? (redirect_to root_url) : (redirect_to session[:back_path])
    else
      render :edit
    end
  end

  private
  def location_params
    :location_param
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :address_line1, :address_line2, :suburb, :state, :postcode)
  end
end
