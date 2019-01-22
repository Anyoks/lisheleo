class AddCenterToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :center_id, :uuid,  foreign_key: true
    add_column :clients, :location, :string
    add_index :clients, :center_id
  end
end
