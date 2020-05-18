class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:authorization_error] = "Not authorized to perform that action"
    redirect_to listings_path
  end 

  def set_profile
    @profile = current_user.profile
  end

end
