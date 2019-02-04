# == Schema Information
#
# Table name: programs
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  sms_description :string
#  parallel        :boolean          default(FALSE)
#  fixed           :boolean          default(FALSE)
#  confirmation    :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  duration        :integer          default(50)
#  code            :string
#  color           :string
#  participants    :integer          default(1), not null
#

require 'rails_helper'

RSpec.describe Program, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
