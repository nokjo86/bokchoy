class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Not authorized to perform that action"
    redirect_to listings_path
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:alert] = "Oops..We can't find what you are looking for."
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

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
