# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  board_id   :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :author_id, :board_id, :name

  belongs_to :board  
  has_many :comments, :dependent => :destroy

  validates_presence_of :name
end
