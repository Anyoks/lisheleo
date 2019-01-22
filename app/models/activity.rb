class Activity < ApplicationRecord
  belongs_to :admin
  belongs_to :activity_type
  has_many :client_activities
  has_many :booking_activities
  
end
