# == Schema Information
#
# Table name: centers
#
#  id           :uuid             not null, primary key
#  name         :string
#  location     :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Center < ApplicationRecord

    has_many :clients
end
