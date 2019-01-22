class ActivityType < ApplicationRecord
    has_many :activities
    has_many :client_activities, through: :activities
    has_many :booking_activities, through: :activities
end
