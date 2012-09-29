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

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
