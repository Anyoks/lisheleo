# == Schema Information
#
# Table name: clients
#
#  id           :uuid             not null, primary key
#  first_name   :string
#  last_name    :string
#  phone_number :string           not null
#  gender       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Client < ApplicationRecord

	has_many :bookings
	has_many :sms


	def full_names
		return "#{self.first_name} #{self.last_name}"
	end
end

