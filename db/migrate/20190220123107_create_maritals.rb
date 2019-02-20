class CreateMaritals < ActiveRecord::Migration[5.1]
  def change
    create_table :maritals do |t|
      t.string :status

      t.timestamps
    end
  end
end
