# == Schema Information
#
# Table name: activities
#
#  id               :uuid             not null, primary key
#  name             :string           not null
#  description      :string
#  admin_id         :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activity_type_id :integer
#

require 'rails_helper'

RSpec.describe Activity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
