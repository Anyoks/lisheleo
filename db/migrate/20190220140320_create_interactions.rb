class CreateInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :interactions, id: :uuid do |t|
      t.string :name
      t.text :description
      t.date :date
      t.references :client, type: :uuid,foreign_key: true

      t.timestamps
    end
  end
end
