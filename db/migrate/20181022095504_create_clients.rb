class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number, null: false, index: true, unique: true
      t.string :gender

      t.timestamps
    end
  end
end
