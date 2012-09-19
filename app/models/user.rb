class User < ActiveRecord::Base
  ROLES = %w[banned author moderator admin]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :title, :body

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
end
