class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Student if user.present?
  end
end
