# == Schema Information
#
# Table name: booking_activities
#
#  id          :uuid             not null, primary key
#  description :string
#  activity_id :uuid
#  booking_id  :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BookingActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :booking
end
