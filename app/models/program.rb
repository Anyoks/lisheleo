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

class Program < ApplicationRecord

	before_save { |program| 
		program.name.nil? ?    program.name : program.name = program.name.downcase 
		program.description.nil? ?  program.description : program.description = program.description.downcase 
		program.sms_description.nil? ?   program.sms_description : program.sms_description = program.sms_description.downcase  }

	validates_presence_of :code, :name, :description
	validates_uniqueness_of  :code, :color
 
	has_many :available_times
	has_many :bookings
	has_many :sms


	def duration_in_seconds
		self.duration * 60
	end

# 	max bookings per day
	def max_sessions day
		# return the number of people allowed to book per day
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

	def max_participants_per_session
		return self.participants
	end

	def max_bookings day
		# total number if clients that can book this program in a particular session on this day
		max_participants_per_session
	end

	def week_max_bookings
		all_days = self.days

		total = 0

		all_days.each do |day|
			total += max_sessions day
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

# 	revise this to inlude double monday or tuesdays etc 
	def sessions_for_day day
		time = self.available_times.where(day: day)
		
		times = []
		if time.present?
			time.each do |t| 
			 times << t.time
			end
			return times
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
			no_of_start_times = self.max_sessions(sess[0]) 

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


	# returns starting times with dates for this whole week regardless of when you are querying
	# that means, when you query on Friday you will get results for the past monday not the next.
	def get_times_and_dates
		starting_times_without_dates = self.get_starting_times_for_sessions

		arr_of_dated_days 	= []

		# collect all keys so that I can modify and add date
		starting_times_without_dates.keys.each { |key|  arr_of_dated_days << key }

		
		# add date to day now
		arr_of_dated_days.collect! do |day|
			date 		= (self.get_date_for day).day #if I want next week's dates, this is where I need to change, get_date_for to get_date_for_next_week
			dated_day 	= day + ' ' + date.to_s

			# replace the array value
			day = dated_day
		end

		# loop through the dated array
		arr_of_dated_days.each do |dated_day|
			# get the hash keys to search through 
			starting_times_without_dates.keys.select {    |key| 
				# replace with the new dated days
				if key.include?(dated_day.split[0])
					hash_key_to_alter = key
					starting_times_without_dates[dated_day] = starting_times_without_dates.delete(hash_key_to_alter)
				end
			}
		end

		return starting_times_without_dates  
	end

	# get tomorrow and future dates, excludin past days' dates
	def get_only_future_days
		starting_times_without_dates = self.get_starting_times_for_sessions

		arr_of_dated_days 	= []

		# collect all keys so that I can modify and add date
		starting_times_without_dates.keys.each { |key|  arr_of_dated_days << key }

		
		# add date to day now
		arr_of_dated_days.collect! do |day|
			date        = Date.today >= self.get_date_for(day) ? (self.get_date_for_next_week day).day : (self.get_date_for day).day #get next weeks dates only
			dated_day 	= day + ' ' + date.to_s

			# replace the array value
			day = dated_day
		end

		# loop through the dated array
		arr_of_dated_days.each do |dated_day|
			# get the hash keys to search through 
			starting_times_without_dates.keys.select {    |key| 
				# replace with the new dated days
				if key.include?(dated_day.split[0])
					hash_key_to_alter = key
					starting_times_without_dates[dated_day] = starting_times_without_dates.delete(hash_key_to_alter)
				end
			}
		end

		return starting_times_without_dates  
	end

	# returns only next weeks dates
	def get_only_next_weeks_dates
		starting_times_without_dates = self.get_starting_times_for_sessions

		arr_of_dated_days 	= []

		# collect all keys so that I can modify and add date
		starting_times_without_dates.keys.each { |key|  arr_of_dated_days << key }

		
		# add date to day now
		arr_of_dated_days.collect! do |day|
			date        = (self.get_date_for_next_week day).day #get next weeks dates only
			dated_day 	= day + ' ' + date.to_s

			# replace the array value
			day = dated_day
		end

		# loop through the dated array
		arr_of_dated_days.each do |dated_day|
			# get the hash keys to search through 
			starting_times_without_dates.keys.select {    |key| 
				# replace with the new dated days
				if key.include?(dated_day.split[0])
					hash_key_to_alter = key
					starting_times_without_dates[dated_day] = starting_times_without_dates.delete(hash_key_to_alter)
				end
			}
		end

		return starting_times_without_dates  
	end

	# this week
	def get_date_for day
		days = { "Monday" => 1 , "Tuesday" => 2 ,  "Wednesday" => 3 , "Thursday" => 4 , "Friday" => 5 }

		diff = days[day] - Date.today.wday
		date = advance_date diff
		return date
	end

	# next week
	def get_date_for_next_week day
		days = { "Monday" => 0 , "Tuesday" => 1 ,  "Wedneday" => 2, "Thursday" => 3 , "Friday" => 4 }

		diff = days[day] #- Date.today.wday
		date = next_week_advance_date diff
		return date
	end

private
	def advance_date diff
		return Date.today.advance(days: diff)
	end

	def next_week_advance_date day
		return Date.today.next_week.advance(days: day)
	end
end
