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

require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
