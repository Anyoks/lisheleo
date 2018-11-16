# == Schema Information
#
# Table name: bookings
#
#  id             :uuid             not null, primary key
#  date           :date
#  description    :string
#  status         :boolean          default(FALSE)
#  confirm_status :string
#  client_id      :uuid
#  sms_id         :uuid
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  time           :datetime
#

class Booking < ApplicationRecord

	belongs_to :sms
	belongs_to :client
	belongs_to :program


	# a booking object is created
	# check if the program is available at suggested time
	# check if there's a booking for that time at that particular date
	# check if 
	# 
	
	# calculate the end of session time
	# def end_time
	# 	self.time + self.program.duration_in_seconds
	# end

	def f_end_time
		(self.time + self.program.duration_in_seconds).strftime("%I:%M %p")
	end

	# what day is it?
	def day
		self.time.strftime("%A")
	end

	# how long is the session?
	def session
		time = self.time.strftime("%I:%M %p")
		end_time = self.end_time.strftime("%I:%M %p")

		return time + ' - ' + end_time
	end


	# check if time slot available for date and time

	def check_booking_eligibility

		# check day
		if self.program.days.include?(self.day)
			# check time
			# convert time to have same date as available time then check
			# if time >= avalable.start_time  && time + duration < available.endtime
			
			# returns "02:00 PM - 04:00 PM" 
			program_time = self.program.sessions_for_day self.day 

			program_start_time = program_time.split('-')[0]
			program_end_time = program_time.split('-')[1]

			if self.time >= Time.zone.parse(program_start_time) && self.end_time <= Time.zone.parse(program_end_time)
				# # check if a booking already exists
				# 
				# check if there's a booking for this program on this date
				bookings = Booking.where(date: self.date, program_id: self.id)

				# check each bookings time
				if bookings.present?
					# how do I search the start times for this collection to see compare with the booking time
					# 
					
				end

				return true
			else
				return false," time is out of range, either too early or too late."
			end
		else
			return false, "Picked the wrong day"
		end
	end


	# check if the date is not today
	# def bookable?
	# 	self.time > Time.zone.
	# end

	# formated time
	def ftime
		self.time.strftime("%I:%M %p")
	end


	def client_first_name
		self.client.first_name
	end

	def client_last_name
		self.client.first_name
	end

	def client_names
		return "#{self.client.first_name} #{self.client.last_name}"
	end

	# private

	def get_hrs_and_min(string)
		
		data = string
		if data.include?('A')
			time = get_24h_for_am(data)

			return time
		elsif data.include?('P')
			time = get_24h_for_pm(data)
			return time 
		else
			return false
		end
	end

	def get_24h_for_am(string)
		data  = string

		hrs_min = data.split('A')[0].split(':') # 2:30am => ['2', '30'] / 2am => ['2']

		hrs     = hrs_min[0].to_i
		min     = hrs_min[1].to_i
		
		return hrs,min
	end

	def get_24h_for_pm(string)
		data  = string

		hrs_min = data.split('P')[0].split(':') # 2:30am => ['2', '30'] / 2am => ['2']

		hrs     = hrs_min[0].to_i
		h24		= hrs > 12 ? hrs + 12 : 12 # to convert to 24h
		min     = hrs_min[1].to_i
		
		return hrs,min
	end

end
