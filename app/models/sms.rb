class Sms < ApplicationRecord

#book
#first_name
#last_name




	def check_format
		self.standardize_sms


		
	end


	private

	def standardize_sms
		text_message  = self.message
		phone_number = self.phone_number
		
		@text_message  = text_message.upcase.downcase!
		@phone_number = phone_number
	end
end
