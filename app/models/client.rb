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
#  center_id    :uuid
#  location     :string
#

class Client < ApplicationRecord

	has_many :bookings
	has_many :sms
	has_many :interactions

	belongs_to :center
	belongs_to :gender
	belongs_to :marital

	validates_presence_of :first_name, :last_name , :phone_number

	def full_names
		return "#{self.first_name} #{self.last_name}"
	end
end

