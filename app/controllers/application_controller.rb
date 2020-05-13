class ApplicationController < ActionController::Base
  def set_profile
    @profile = current_user.profile
  end
end
