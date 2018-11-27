class Api::V1::SmsController < ActionController::API

	def create
		@sms = Sms.new(sms_params)

		check = @sms.check_format

		if check == true

			details 		= @sms.extract_details

			booking 		= details.book_time_slot

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
		elsif check == "inquiry"
			return lishe_details
		else

			# @sms.save
			@failed_sms_bookings = FailedSmsBooking.new(sms_params)
			@failed_sms_bookings.save

			return book_instructions
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
				message: "Sorry the booking was not successful. We suggest #{message[0]} Kindly try again", 
				phone_number: "#{@sms.phone_number}"
			}
			
		]}, status: :ok
	end

	def sms_params
	  params.permit(:phone_number,:message)
	end
end
