# == Schema Information
#
# Table name: available_times
#
#  id         :integer          not null, primary key
#  day        :string
#  start_time :time
#  end_time   :time
#  program_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe AvailableTime, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
