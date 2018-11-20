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
	def max_bookings day
		# find the duration of the session (start_time  - end_time in minutes ) then divide by session 
		# duration to find the  bookings per day on the fly.
		available_times_for_this_day = self.available_times.where(day: day)

		total_session_time = 0
		if available_times_for_this_day.count > 0
			available_times_for_this_day.each do |val|
				time_in_seconds = val.end_time - val.start_time
				total_session_time += time_in_seconds
			end

			total_session_time_in_minutes = total_session_time/60
			max_bookings = total_session_time_in_minutes / self.duration

			return max_bookings.to_i
		else
			return total_session_time
		end

	end

	def week_max_bookings
		all_days = self.days

		total = 0

		all_days.each do |day|
			total += max_bookings day
		end

		return total
	end

	def sessions

		days = []
		times = []
		sessions = {}

		self.available_times.each do |time|
			# days << time.day
			# times << time.time
			 if sessions.key?(time.day)
			 	sessions[time.day] << ", #{time.time}"
			 else
				sessions[time.day] = time.time
			end
		end
		# hash = Hash[*days.zip(times).flatten]
		# return hash
		return sessions		
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
			days << time.day.strip
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

	def latest_booking_times

		sessions = {}

		self.available_times.each do |avail|
			if sessions.key?(avail.day)
				sessions[avail.day] << ", #{avail.latest_booking_time}"
			else
				sessions[avail.day] = avail.latest_booking_time
			end
		end

		return sessions #{"Friday"=>"11:10 AM", "Monday"=>"03:10 PM"} 
		
	end

	def get_starting_times_for_sessions
		session_times = self.sessions

		starting_times_for_each_session = {}#this week
		last_booking_times              = self.latest_booking_times

		session_times.each do |sess|
			# sess {"Monday"=>"06:00 AM - 07:00 AM, 06:00 PM - 07:00 PM"} 
			no_of_start_times = self.max_bookings(sess[0]) 

			start_end_times_list = sess[1].split(',') # result ::  ["06:00 AM - 07:00 AM", " 06:00 PM - 07:00 PM"]

			# start_end_times.size
			start_end_times_real = [] # this will hold the starting and ending times separated by commas
			i = 0
			while i < start_end_times_list.size
				start_end_times_real << start_end_times_list[i].split('-') # result::  [["06:00 AM ", " 07:00 AM"], [" 06:00 PM ", " 07:00 PM"]] 
				i = i + 1
			end	

			# puts "Back to main loop ******"
			starting_times_for_each_session[sess[0]] = []#start_end_times_real[0][0]
			s = 0 #starting and ending times array counter
			j = 0 #no of booking times for particular day counter
			while s < start_end_times_real.size
				
					starting_times_for_each_session[sess[0]] << start_end_times_real[s][0] #"06:00 PM " & "06:00 AM"
					# puts "Back to while loop ******"
				
					while j < no_of_start_times
						# byebug
						# sometimes the j counter goes ahead, when a time  is not inserted into the hash, so we have to take it back by one when that happens
						booking_time =  starting_times_for_each_session[sess[0]][j].nil?  ?  "#{(Time.zone.parse(starting_times_for_each_session[sess[0]][j-1]) + (self.duration * 60)).strftime("%I:%M %p")}"  : "#{(Time.zone.parse(starting_times_for_each_session[sess[0]][j]) + (self.duration * 60)).strftime("%I:%M %p")}"
						
						latest_time_to_book = last_booking_times[sess[0]]
						# puts "last booking #{latest_time_to_book} "
						# puts "booking #{latest_time_to_book} "
						if Time.zone.parse(booking_time) <=  Time.zone.parse(latest_time_to_book)
							starting_times_for_each_session[sess[0]] <<  (Time.zone.parse(starting_times_for_each_session[sess[0]][j]) + (self.duration * 60)).strftime("%I:%M %p")  #2nd start time
						end

						j += 1						
					end
				s = s + 1
			end
			
			# puts "#{no_of_start_times}"
			
		end
		
		return starting_times_for_each_session
	end
end
