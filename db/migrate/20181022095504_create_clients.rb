class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :gender

      t.timestamps
    end
  end
end
