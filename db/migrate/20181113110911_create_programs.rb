class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.string :sms_description
      t.boolean :parallel, default: false
      t.boolean :fixed, default: false
      t.boolean :confirmation, default: false

      t.timestamps
    end
  end
end
