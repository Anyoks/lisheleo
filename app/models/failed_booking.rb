# == Schema Information
#
# Table name: failed_bookings
#
#  id          :uuid             not null, primary key
#  date        :date
#  description :string
#  client_id   :uuid
#  sms_id      :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  time        :datetime
#

class FailedBooking < ApplicationRecord
end
