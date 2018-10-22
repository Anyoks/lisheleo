class AddClientIdToSms < ActiveRecord::Migration[5.1]
  def change
    add_column :sms, :client_id, :uuid, foreign_key: true
  end
end
