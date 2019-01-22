class CreateActivityTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
