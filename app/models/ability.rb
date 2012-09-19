class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.role? :admin
      can :manage, :all
    end

    if user.role? :moderator
      can :manage, Board, :moderator_id => user.id
      end
    end

    if user.role? :author
      can :manage, Comment, :author_id => user.id
      end
    end
    
    can :read, :all
  end
end
