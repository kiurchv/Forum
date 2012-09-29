# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string(255)
#  name                   :string(255)
#

class User < ActiveRecord::Base
  ROLES = %w[admin moderator author readonly]

  attr_accessible :name, :role, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates :name, :presence => true
  validates :role, :inclusion => { :in => ROLES }, :on => :update

  before_create :set_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_many :topics, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  def role?(base_role)
    ROLES.index(base_role.to_s) >= ROLES.index(role)
  end

  private

  def set_role
    if User.count > 0
      self.role = ROLES[2]
    else
      self.role = ROLES[0]
    end
  end
end
