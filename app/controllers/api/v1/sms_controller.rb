class Api::V1::SmsController < ActionController::API

	def create
		@sms = Sms.new(sms_params)

		check = @sms.check_format

		if check

			details 		= @sms.extract_details
			booking 		= details.book_time_slot

			if  booking[0]
				return successful_booking booking[1]
			else
				return failed_booking booking[1]
			end
			
		else

			# @sms.save
			@failed_sms_bookings = FailedSmsBooking.new(sms_params)
			@failed_sms_bookings.save

			return book_instructions
		end
	end




	protected

	def book_instructions
		render json: { sms: [success: true, message: "To book a consultation reply with: B# dd/mm time, first_name, last_name. e.g B# 12/2 9am John Doe", phone_number: "#{@sms.phone_number}"]}, status: :ok
	end

	def successful_booking booking
		render json: { sms: [success: true, message: "Thank you #{booking.client_first_name} for booking lishe leo. Your appointment is scheduled for #{booking.time.strftime("%A %d")} at  #{booking.time.strftime("%I:%M %P")}  ", phone_number: "#{@sms.phone_number}"]}, status: :ok
	end

	def failed_booking failed_booking
		render json: { sms: [success: true, message: "Sorry the booking was not successful. Kindly check your booking details", phone_number: "#{@sms.phone_number}"]}, status: :ok
	end

	def sms_params
	  params.permit(:phone_number,:message)
	end
end
