# == Schema Information
#
# Table name: sms
#
#  id           :uuid             not null, primary key
#  message      :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  date         :date
#  first_name   :string
#  last_name    :string
#  status       :boolean          default(FALSE)
#  client_id    :uuid
#  time         :datetime
#

class Sms < ApplicationRecord

	# has_many :failed_bookings

	has_one :booking
	belongs_to :client
	belongs_to :program
#  book
#first_name
#last_name

=begin
**sample sms ****
B# dd/mm 9am Dennis Orina
B# dd/mm 9:30pm Dennis Orina
=end

	################################################################
	#######  Confirmation sms sample                        ########
	#######  Hallo client.name, you made a booking for      ########
	#######  date at time. Will you be avaibable? send Y to ########
	#######  to confirm and N to cancel. Lishe leo          ########
	################################################################
	#
	#
	# def client
	# 	Client.where(phone_number: self.phone_number).first
	# end

	def check_format

		########################################################
		######## ******   Sample sms  ******* ##################
		######## B# 12/10/2018 9am dennis orina ###################
		########################################################

		self.standardize_sms

		if @text_message.include?('#')

			split = @text_message.split('#')

			if split.size == 2
				# "B1"
				if split[0].size == 2
					#  ["tuesday", "9am", "Dennis", "Orina"]
					if split[1].split(' ').size == 4
						return true
					else
						return false
					end
				else
					return false #no program number
				end
			else
				return false
			end
		elsif @text_message.include?('?')
			return "inquiry"			
		else

			return false
		end
	end


# Ran only if the format is right.
	def extract_details
		# self.standardize_sms
		
		if self.check_format
			logger.debug "Extracting details"
			
			split = @text_message.split('#')

			code = split[0].upcase

			program = Program.where(code: code).first
			
			# if Program is found
			if program.present?
				# ["B1", " 12/10/2018 9am dennis orina"] 
				raw = split[1].split(' ')

				date 		 = get_date raw[0]
				time		 = get_time(date,raw[1])
				first_name	 = raw[2]
				last_name 	 = raw[3]
				program_id 	 = program.id
				save_params  = []

				# create the client
				# byebug

				client				= Client.where( phone_number: "#{@phone_number}").first_or_initialize #Client.new( first_name: "#{first_name}", last_name: "#{last_name}", phone_number: "#{@phone_number}")
				client.first_name   = first_name
				client.last_name 	= last_name
				client.save


				# ["phone_number", "message", "date", "time", "first_name", "last_name","program_id"] 
				save_params << @phone_number << @text_message << date << time << first_name << last_name << client.id << program_id
				sms_data 	 = sms_params save_params

				@sms  	 	 = Sms.new(sms_data)
						
				
				if @sms.save!
					# byebug
					return @sms
				else
					return false
				end
			end			
		else
			return false
		end

		
	end


	
	def book_time_slot#(client_id)
		# check if the booking slot already exists then book
		date 				= self.date
		time 				= self.time
		client 	 			= self.client_id
		confirm_status 		= "pending" # status can be 1. pending 2. confirmed 3. cancelled
		description			= "Booking and appointment"
		sms_id				= self.id
		program_id			= self.program_id

		# byebug

		# add validations.....check the date and the time, for any conflicting bookings before save

		booking 			= Booking.new( time: time, date: date, client_id: client, confirm_status: confirm_status, description: description, sms_id: sms_id, program_id: program_id)
		booking.end_time 	= booking.time + booking.program.duration_in_seconds 
		# byebug
		eligible  			= booking.check_booking_eligibility
		if eligible[0]
			# if booking.save
			# 	# end_time 			= booking.time + booking.program.duration_in_seconds 
			# 	# booking.update_attributes(end_time: end_time)
			# 	return true, booking
			# else
			# 	description			= "the particular error that caused this booking to fail"
			# 	failed_booking = FailedBooking.new( time: time, date: date, client_id: client, description: description, sms_id: sms_id)
			# 	return false, failed_booking
			# end
			return eligible[1]
		else
			return eligible[1]
		end
	end

	def get_date string
		day 	 = string.split('/')[0].to_i
		month	 = string.split('/')[1].to_i
		year 	 = Time.zone.now.year

		# Date.new(yyyy, mm, dd)
		# Date.new(2018, 2, 12)

		date = Date.new( year, month, day)

		return date
	end

	def get_time date, string

		date = date
		data = get_hrs_and_min string
		
		hrs  = data[0]
		min  = data[1]
		sec  = 00

		time = Time.zone.local(date.year, date.month, date.day, hrs, min)
		
		return time
	end

	def get_hrs_and_min(string)
		
		data = string
		if data.include?('a')
			time = get_24h_for_am(data)

			return time
		elsif data.include?('p')
			time = get_24h_for_pm(data)
			return time 
		else
			return false
		end
	end

	def get_24h_for_am(string)
		data  = string

		hrs_min = data.split('a')[0].split(':') # 2:30am => ['2', '30'] / 2am => ['2']

		hrs     = hrs_min[0].to_i
		min     = hrs_min[1].to_i
		
		return hrs,min
	end

	def get_24h_for_pm(string)
		data  = string

		hrs_min = data.split('p')[0].split(':') # 2:30am => ['2', '30'] / 2am => ['2']

		hrs     = hrs_min[0].to_i
		h24		= hrs > 12 ? hrs + 12 : 12 # to convert to 24h
		min     = hrs_min[1].to_i
		
		return hrs,min
	end



	protected

	def standardize_sms
		text_message  = self.message
		phone_number = self.phone_number
		
		@text_message  = text_message.upcase.downcase
		@phone_number = phone_number
	end

	def sms_params data
		name = ["phone_number", "message", "date", "time", "first_name", "last_name", "client_id","program_id"] 
		hash = Hash[*name.zip(data).flatten]
		return hash
	end
end
