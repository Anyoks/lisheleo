# == Schema Information
#
# Table name: sms
#
#  id           :uuid             not null, primary key
#  message      :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  date         :date
#  first_name   :string
#  last_name    :string
#  status       :boolean          default(FALSE)
#  client_id    :uuid
#  time         :datetime
#

require 'rails_helper'

RSpec.describe Sms, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
