class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    case user.role
    when "admin"
      can :manage, :all
    when "moderator"
      can :manage, Board, :moderator_id => user.id
      cannot :destroy, Board
    when "author"
      can :manage, [Topic, Comment], :author_id => user.id
    else
      can :read, :all
    end
  end
end