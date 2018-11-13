# == Schema Information
#
# Table name: programs
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  sms_description :string
#  parallel        :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Program < ApplicationRecord

	has_many :available_times
end
