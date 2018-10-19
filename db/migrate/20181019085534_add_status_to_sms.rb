class AddStatusToSms < ActiveRecord::Migration[5.1]
  def change
    add_column :sms, :status, :boolean, default: false
  end
end
