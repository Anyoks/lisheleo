class Client < ApplicationRecord

	has_many :bookings
	has_many :sms
end
