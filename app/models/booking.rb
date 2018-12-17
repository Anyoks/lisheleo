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

	validates :time, uniqueness: { scope: [:program_id ]} #, :another_medium] }

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

	def ftime
		self.time.strftime("%I:%M %p")
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



			# check if the user's proposed booking time is within the allowed booking hours
			if Time.zone.parse(self.ftime) >= Time.zone.parse(program_start_time) && Time.zone.parse(self.f_end_time) < Time.zone.parse(program_end_time)
				# byebug
				# # check if a booking already exists for that particular time
				# 
				# check if there's a booking for this program on this date & time
				bookings = Booking.where(date: self.date, time: self.time ,program_id: self.program.id)
				
				# check each bookings time
				if bookings.present?
					
					# check if max bookings for this day have been reached
					if bookings.count >= self.program.max_bookings(self.day)

						# I'm thinking I should query available slots and present the user with proposed time
						# slots for booking as opposed to leave them guessing till they get it right.
						# Maybe return a 2 day list of available slot times, e. Monday 12 2pm, 3pm 4pm, Tue 13 8am, 9am 
						# wed, 3pm etc
						
						# return false, "This day is fully booked"
						return available_slots_this_week#, "This day is fully booked"
					else
						# check if the users' time slot is already taken
						#check the start times for this session and tell give the user a choice if thier's
						#don't fall in that range.
						
						ending = self.f_end_time

						# find starting times then select for this day
						# 
						# search Db for which one exists and suggest the other one.
						checking = self.program.get_starting_times_for_sessions # e.g {"Tuesday"=>["02:00 PM ", "02:50 PM"], "Thursday"=>["08:30 AM "]} 
						today    = checking[self.day] # e.g ["02:00 PM ", "02:50 PM"] 

						counter = 0
						# byebug
						while counter <= today.size
							
							if bookings.where(end_time: Time.zone.parse(today[counter])).present?
								# this time slot has been taken.
								# return suggested time slots for today
								if self.date > Date.today 
									if Time.zone.now > Time.zone.parse(today[counter+1])
										puts "Here today  #{today}  counter #{counter}"
										return true , today[counter+1]# "This slot is taken but there's one available today"
										break
									else
										# you cannot book a passed time
										return available_slots_this_week
									end
								else
									# you cannot book a passed date
									# return suggested booking dates
									return available_slots_this_week 
								end
							else								
								# if the available time is passed, then don't suggest it.
								if self.date > Date.today 
									# check the time
									# byebug
									if Time.zone.now > Time.zone.parse(today[counter])
										# byebug
										# now we can pick a time and book a slot or suggest a time slot to the user
										# puts "Here today1  #{today}  counter1 #{counter}"
										# return true this is a successful booking
										# Okay we can book
										# return true, today[counter] #{}"This time slot is present"

										# check if it first exists in the db
										if Booking.where(end_time: self.time, program_id: self.program.id).count > 0
											# such a booking exists, suggest another time
											return available_slots_this_week
										else
											return true
											break
										end

										
									else
										# you cannot book a passed time
										return available_slots_this_week
									end
								else
									# you cannot book a passed date
									# return suggested booking dates
									return available_slots_this_week 
								end	
							end

							counter +=1
						end				
					end
				else
					# return true, this is a successful booking
					# return true, "there are no booking today You can book successfully"
					return true
				end

				# return true
			else
				# return available days for this program
				# return false," time is out of range, either too early or too late."
				return available_slots_this_week
			end
		else
			# return available days for this program
			# return false, "Picked the wrong day"
			return available_slots_this_week
		end
	end

	# try suggesting times without the booking time that failed.
	def available_slots_this_week
		days 	 = self.program.days #.include?(self.day)
		bookings = Booking.where(date: self.date, program_id: self.id)
		program  = self.program

		# starting date is today's date
		
		advance = advance_date

		total_bookings_possible = program.week_max_bookings #possible bookings for this program


		if advance.class.name != "Array"

			this_week_bookings = program.bookings.where(date: Date.today..advance_date )  #put a date range for this week and next week
			
			if this_week_bookings.count == total_bookings_possible
				
				# "This week is fully booked"
				# return next weeks available time slots
				return true, self.program.get_only_next_weeks_dates
			else
				# return the available slot start_times, days and dates. i,e Monday 12th 9am
				return true ,self.program.get_only_future_days
			end

			# 
			# next_week_bookings = program.bookings.where(date: Date.today.next_week..Date.today.next_week.advance(days: 4) )
			
			# return this_week_bookings.count #, next_week_bookings.count  #put a date range for this week and next week
		else
			return false, advance[1]
		end
	end

	def available_slots_next_week
		days 	 = self.program.days #.include?(self.day)
		bookings = Booking.where(date: self.date, program_id: self.id)
		program  = self.program

		# starting date is today's date
		advance = next_week_advance_date

		total_bookings_possible = program.week_max_bookings #possible bookings for this program


		if advance.class.name != "Array"

			next_week_bookings = program.bookings.where(date: Date.today.next_week..next_week_advance_date )  #put a date range for this week and next week
			
			if next_week_bookings.count == total_bookings_possible
				
				# return 0, "This week is fully booked"
				# return next weeks available time slots
				return true, self.program.get_only_next_weeks_dates # get slots for the other week
			else
				# return the available slot start_times, days and dates. i,e Monday 12th 9am
				return true, self.program.get_only_next_weeks_dates
			end

			# 
			# next_week_bookings = program.bookings.where(date: Date.today.next_week..Date.today.next_week.advance(days: 4) )
			
			# return next_week_bookings.count #, next_week_bookings.count  #put a date range for this week and next week
		else
			return false, advance[1]
		end
	end

	def advance_date
		#  0 - Sunday, 5 - Friday
		today = Date.today.wday
		if today == 0 # if today is Sun
			return false, "no bookings on sunday"
		elsif today == 1 # Monday
			return Date.today.advance( days: 4)
		elsif today == 2 # Tue
			return Date.today.advance( days: 3)
		elsif today == 3 # Wed
			return  Date.today.advance( days: 2)
		elsif today == 4 # Thur
			return Date.today.advance( days: 1)
		elsif today == 5 # Fi
			return Date.today.advance( days: 0)
		elsif today == 6 # Thur
			return false, "No bookings on Sabbath"
		else
			return false, "Out of range" # out of range
		end
	end

	def next_week_advance_date
		#  0 - Monday, 4 - Friday
		monday = Date.today.next_week.wday
		
		if monday == 1 # Monday
			return Date.today.next_week.advance( days: 4)
		elsif monday == 2 # Tue
			return Date.today.next_week.advance( days: 3)
		elsif monday == 3 # Wed
			return  Date.today.next_week.advance( days: 2)
		elsif monday == 4 # Thur
			return Date.today.next_week.advance( days: 1)
		elsif monday == 5 # Fi
			return Date.today.next_week.advance( days: 0)
		elsif monday == 6 # Thur
			return false, "No bookings on Sabbath"
		else
			return false, "Out of range"# out of range
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
