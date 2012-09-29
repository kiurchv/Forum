# == Schema Information
#
# Table name: boards
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Board < ActiveRecord::Base
  attr_accessible :name, :description, :moderator_id
  
  has_many :topics, :dependent => :destroy

  validates :name, :moderator_id, :presence => true
  validates :name, :length => { :maximum => 50 }
  validates :description, :length => { :maximum => 300 }

  # def to_param
  #   name.parametrize
  # end
end