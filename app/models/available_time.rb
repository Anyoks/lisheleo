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



	def time
		time = self.start_time.strftime("%I:%M %p")
		end_time = self.end_time.strftime("%I:%M %p")

		return time + ' - ' + end_time
	end

	# formated time
	def fstart_time
		self.start_time.strftime("%I:%M %p")
	end

	def fend_time
		self.start_time.strftime("%I:%M %p")
	end


	# returns ending time - program duration to make sure tht last booking does no ve a few minutes
	def latest_booking_time
		time = (self.end_time - self.program.duration_in_seconds).strftime("%I:%M %p")
		return time
	end
end
