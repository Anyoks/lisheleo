class CreateClientActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :client_activities, id: :uuid do |t|
      t.string :description
      t.uuid :activity_id, foreign_key: true
      t.uuid :client_id, foreign_key: true

      t.timestamps
    end
  end
end
