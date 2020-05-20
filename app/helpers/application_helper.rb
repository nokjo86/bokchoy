module ApplicationHelper
  def account_owner?(subject)
    if user_signed_in? && current_user.profile.id == subject.profile_id
      true
    else
      false
    end
  end
end
