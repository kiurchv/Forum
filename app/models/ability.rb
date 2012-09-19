class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
      can :manage, :all
    end

    if user.role? :moderator
      can :manage, Forum, :moderator => user.id
      end
    end

    if user.role? :author
      can :manage, Post, :author => user.id
      end
    end
    
    can :read, :all
  end
end
