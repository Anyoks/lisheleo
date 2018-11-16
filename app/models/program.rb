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
	has_many :bookings
	has_many :sms


	def duration_in_seconds
		self.duration * 60
	end

# 	max bookings per day
	def max_bookings
		
	end

	def sessions

		days = []
		times = []

		self.available_times.each do |time|
			days << time.day
			times << time.time
		end
		hash = Hash[*days.zip(times).flatten]
		return hash			
	end

	def sessions_for_day day
		time = self.available_times.where(day: day).first

		if time.present?
			return time.time
		else
			return false
		end
	end

	def days
		days = []

		self.available_times.each do |time|
			days << time.day
		end

		return days
	end

	def times
		times = []

		self.available_times.each do |time|
			times << time.time
		end

		return times
	end
end
