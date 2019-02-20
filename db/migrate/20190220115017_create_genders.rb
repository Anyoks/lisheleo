class CreateGenders < ActiveRecord::Migration[5.1]
  def change
    create_table :genders  do |t|
      t.string :gender

      t.timestamps
    end
  end
end
