# == Schema Information
#
# Table name: available_times
#
#  id         :integer          not null, primary key
#  day        :string
#  start_time :time
#  end_time   :time
#  program_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AvailableTime < ApplicationRecord
	belongs_to :program
end
