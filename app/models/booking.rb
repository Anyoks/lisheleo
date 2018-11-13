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
