# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  topic_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :topic_id, :user_id, :content

  belongs_to :topic
  belongs_to :user

  validates :content, :presence => true

  validates_associated :topic
  validates_associated :user
end
