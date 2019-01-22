class ClientActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :client
end
