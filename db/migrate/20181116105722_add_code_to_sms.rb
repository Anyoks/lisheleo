class AddCodeToSms < ActiveRecord::Migration[5.1]
  def change
    add_column :sms, :code, :string
    add_column :sms, :program_id, :integer, foreign_key: true
  end
end
