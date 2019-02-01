# == Schema Information
#
# Table name: activity_types
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ActivityType < ApplicationRecord
    has_many :activities
    has_many :client_activities, through: :activities
    has_many :booking_activities, through: :activities
end
