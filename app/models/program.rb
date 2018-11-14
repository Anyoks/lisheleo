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
#

class Program < ApplicationRecord

	before_save { |program| 
		program.name.nil? ?    program.name : program.name = program.name.downcase 
		program.description.nil? ?  program.description : program.description = program.description.downcase 
		program.sms_description.nil? ?   program.sms_description : program.sms_description = program.sms_description.downcase  }

	has_many :available_times
end