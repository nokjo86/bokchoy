# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :create], Listing
    if user.present?
      can :manage, Listing, profile_id: user.profile.id
      can :manage, Profile, user_id: user.id
      if user.admin?
        can :manage, :all
      end
    end
  end
end
