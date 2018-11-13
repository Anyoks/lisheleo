# == Schema Information
#
# Table name: failed_sms_bookings
#
#  id           :uuid             not null, primary key
#  phone_number :string
#  message      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class FailedSmsBooking < ApplicationRecord
end
