# == Schema Information
#
# Table name: activities
#
#  id               :uuid             not null, primary key
#  name             :string           not null
#  description      :string
#  admin_id         :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activity_type_id :integer
#

class Activity < ApplicationRecord
  belongs_to :admin
  belongs_to :activity_type
  has_many :client_activities
  has_many :booking_activities
  # ActiveRecord::Base.default_timezone = :utc

end
