# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  board_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :board_id, :user_id, :name

  belongs_to :board
  belongs_to :user

  has_many :comments, :dependent => :destroy

  validates :name, :presence => true, :length => { :maximum => 50 }
  
  validates_associated :board
  validates_associated :user
end
