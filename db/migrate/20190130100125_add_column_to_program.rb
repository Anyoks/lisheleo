class AddColumnToProgram < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :participants, :integer, default: 1, null: false
  end
end
