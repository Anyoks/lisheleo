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

require 'rails_helper'

RSpec.describe FailedSmsBooking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
