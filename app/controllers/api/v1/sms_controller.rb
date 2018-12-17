class Api::V1::SmsController < ActionController::API

	def create
		@sms = Sms.new(sms_params)

		check = @sms.check_format

		if check.class != Array
			if check == true

				@sms 		= @sms.extract_details
	
				booking 		= @sms.book_time_slot
	
				if  booking[0]
					return successful_booking booking[1]
				else
					# here booking one could be a hash with suggestions or a text
					if booking[1].class == Hash
						message = @sms.generate_sms booking[1]
						return failed_booking message
					else
						return failed_booking booking[1]
					end
				end
			else
				# @sms.save
				@failed_sms_bookings = FailedSmsBooking.new(sms_params)
				@failed_sms_bookings.save

				return book_instructions
			end
			
		else		
			
			if check[1].class == Hash
				# generate sms of suggestions
				message = @sms.generate_sms check[1]
				# byebug
				program = @sms.program.name.camelize
				return lishe_inquiry(message, program)
			elsif check[2] == false
				# no such program
				message = check[1]
				return lishe_inquiry_no_such_program(message)
			else
				# error with detail req sms
				return lishe_inquiry_instructions
			end
					
		end
	end




	protected

	def book_instructions
		sms_message = "B1. Personalized Wellness\n B2. Therapeutic Massage \n B3. Keep Fit \n B4. Cancer support \n B5. Weight management "
		render json: { sms: [
			{

				success: true, 
				message: "To book a consultation reply with: B?# dd/mm time, first_name, last_name. e.g for Keep fit: B3# 12/2 9am John Doe. To get information on booking options reply with ?",
				phone_number: "#{@sms.phone_number}"
			}
			
			]
		}, status: :ok
	end

	def lishe_details

		book_details = "To book a consultation reply with: B?# dd/mm time, first_name, last_name. e.g for Keep fit: B3# 12/2 9am John Doe."
		render json: { sms: [
			{

				success: true, 
				message: "B1. Personalized Wellness\n B2. Therapeutic Massage \n B3. Keep Fit \n B4. Cancer support \n B5. Weight management. \n To get more details on each \n option, reply with B?# e.g For Keep fit: B3#. #{book_details}",
				phone_number: "#{@sms.phone_number}"
			}
			
			]
		}, status: :ok
	end

	def lishe_inquiry(messages,program_name)
		book_details = "To book a consultation reply with: B?# dd/mm time, first_name, last_name. e.g for Keep fit: B3# 12/2 9am John Doe."
		render json: { sms: [
			{

				success: true, 
				message: "For #{program_name}, available sessions are on #{messages}. #{book_details}",
				phone_number: "#{@sms.phone_number}"
			}
			
			]
		}, status: :ok
	end

	def lishe_inquiry_no_such_program(messages)
		book_details = "To book a consultation reply with: B?# dd/mm time, first_name, last_name. e.g for Keep fit: B3# 12/2 9am John Doe."
		render json: { sms: [
			{

				success: true, 
				message: "Sorry #{messages}. #{book_details} ",
				phone_number: "#{@sms.phone_number}"
			}
			
			]
		}, status: :ok
	end

	def lishe_inquiry_instructions
		book_details = "To book a consultation reply with: B?# dd/mm time, first_name, last_name. e.g for Keep fit: B3# 12/2 9am John Doe."

		program_details = "B1. Personalized Wellness\n B2. Therapeutic Massage \n B3. Keep Fit \n B4. Cancer support \n B5. Weight management."
		code_inq = "?Bx#"
		render json: { sms: [
			{

				success: true, 
				message: "To inquire about a program, send ?program code e.g ?B3 for details on Keep fit. #{book_details}. Program codes are as follows: #{program_details} ",
				phone_number: "#{@sms.phone_number}"
			}
			
			]
		}, status: :ok
	end
	

	def successful_booking booking
		render json: { sms: [

			{

				success: true,
				message: "Thank you #{booking.client_first_name} for booking #{booking.program.name}. Your appointment is scheduled for #{booking.time.strftime("%A %d")} at  #{booking.time.strftime("%I:%M %P")}  ", 
				phone_number: "#{@sms.phone_number}"
			}
			
			]
		}, status: :ok
	end

	def failed_booking message
		render json: { sms: [
			{

				success: true, 
				message: "Sorry the booking was not successful. We suggest you pick another time slot, #{message} Kindly check your dates & try again", 
				phone_number: "#{@sms.phone_number}"
			}
			
		]}, status: :ok
	end

	def sms_params
	  params.permit(:phone_number,:message)
	end
end
