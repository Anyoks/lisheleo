class Booking < ApplicationRecord

	belongs_to :sms
	belongs_to :client


	def client_first_name
		self.client.first_name
	end

	def client_last_name
		self.client.first_name
	end

	def client_names
		return "#{self.client.first_name} #{self.client.last_name}"
	end

end
