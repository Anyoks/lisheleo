class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities, id: :uuid do |t|
      t.string :name,  null: false
      t.string :description
      t.uuid :admin_id, foreign_key: true

      t.timestamps
    end
  end
end
