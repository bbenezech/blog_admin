class Ability
  include CanCan::Ability

  def initialize(user)
    case user.profile
    when 'admin'
      can :manage, :all
    when 'writer'
      can :access, :rails_admin
      can :dashboard
      can :manage, Blog::Post, { user_id: user.id }
    end
  end
end
