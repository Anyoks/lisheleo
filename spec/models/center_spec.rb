# == Schema Information
#
# Table name: centers
#
#  id           :uuid             not null, primary key
#  name         :string
#  location     :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Center, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
