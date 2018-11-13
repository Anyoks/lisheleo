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

require 'rails_helper'

RSpec.describe Booking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
