class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Not authorized to perform that action"
    redirect_to listings_path
  end 

  def set_profile
    @profile = current_user.profile
  end

  def profile_blank?
    if current_user.profile.first_name? == false
    flash[:alert] = "Please update your profile first"
    session[:back_path] = request.url
    redirect_to profile_edit_path
    end
  end
end