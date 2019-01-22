class AddTypeToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :activity_type_id, :integer,foreign_key: true
    add_index :activities, :activity_type_id
  end
end
