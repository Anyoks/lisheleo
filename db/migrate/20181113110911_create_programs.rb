class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.string :sms_description
      t.boolean :parallel

      t.timestamps
    end
  end
end
