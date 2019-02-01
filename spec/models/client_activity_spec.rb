# == Schema Information
#
# Table name: client_activities
#
#  id          :uuid             not null, primary key
#  description :string
#  activity_id :uuid
#  client_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ClientActivity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
