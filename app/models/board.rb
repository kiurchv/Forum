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
  attr_accessible :description, :moderator_id, :name
  
  has_many :topics, :dependent => :destroy

  validates_presence_of :name
end
