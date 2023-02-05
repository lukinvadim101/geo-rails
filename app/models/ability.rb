# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.admin?
      can :manage, :all
    else
      can :checkin, :all
      can :create, Location
      can [:read, :update, :destroy], Location do |location|
        location.try(:user) == user
      end
    end
  end
end
