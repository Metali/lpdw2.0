# == Schema Information
#
# Table name: projects
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  description            :text
#  link                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  thumbmail_file_name    :string(255)
#  thumbmail_content_type :string(255)
#  thumbmail_file_size    :integer
#  thumbmail_updated_at   :datetime
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
