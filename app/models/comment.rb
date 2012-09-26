# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  topic_id   :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :author_id, :content, :topic_id

  belongs_to :topic

  validates :content, :presence => true
  validates_associated :topic
end