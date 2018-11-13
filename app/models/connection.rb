# == Schema Information
#
# Table name: connections
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Connection < ApplicationRecord
end
