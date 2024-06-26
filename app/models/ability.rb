class Ability
  include CanCan::Ability
  include ActiveAdminRole::CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    if user.super_user?
      can :manage, :all
    else
      register_role_based_abilities(user)
    end

    # NOTE: Everyone can read the page of Permission Deny
    can :read, ActiveAdmin::Page, name: "Dashboard"
    can :read, ActiveAdmin::Page, name: "AboutUs"
    # can :read, ProductSize
    # can :read, Category
    can :read, Product
    can :read, Order
    can :read, Plan
    can :read, Subscription
    can :read, Charge
    can :read, Notification

    can :read, Item
    can :read, RozarpayPlan
    can :read, RozarpaySubscription
    can :manage, Conversation
  end
end
