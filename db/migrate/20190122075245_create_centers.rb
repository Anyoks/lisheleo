class CreateCenters < ActiveRecord::Migration[5.1]
  def change
    create_table :centers, id: :uuid do |t|
      t.string :name
      t.string :location
      t.string :phone_number

      t.timestamps
    end
  end
end
