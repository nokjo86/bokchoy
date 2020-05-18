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
    if @profile.update(profile_params)
      redirect_to session[:back_path]
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
