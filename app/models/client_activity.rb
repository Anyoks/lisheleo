# == Schema Information
#
# Table name: client_activities
#
#  id          :uuid             not null, primary key
#  description :string
#  activity_id :uuid
#  client_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ClientActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :client
end
