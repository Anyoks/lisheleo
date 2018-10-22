class AddDateToSms < ActiveRecord::Migration[5.1]
  def change
    add_column :sms, :date, :date
    add_column :sms, :time, :time
    add_column :sms, :first_name, :string
    add_column :sms, :last_name, :string
  end
end
