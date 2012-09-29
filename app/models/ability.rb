class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => 'readonly') # guest user (not logged in)
    
    if user.role? :readonly
      can :create, User
      can :read, :all
    end

    if user.role? :author
      can :manage, User, :id => user.id
      cannot :assign_roles, User
      can :create, [Topic, Comment]
      can :manage, [Topic, Comment], :user => user
    end
    
    if user.role? :moderator
      can :manage, Board, :moderator_id => user.id
      cannot :destroy, Board
      can :manage, Topic, :board => { :moderator_id => user.id }
      can :manage, Comment, :topic => { :board => { :moderator_id => user.id } }
    end
    
    if user.role? :admin
      can :manage, :all
      can :assign_roles, User
    end
  end
end