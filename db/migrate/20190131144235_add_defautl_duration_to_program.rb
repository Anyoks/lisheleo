class AddDefautlDurationToProgram < ActiveRecord::Migration[5.1]
  def up
    change_column :programs, :duration, :integer, :default => 50
  end

  def down
    change_column :programs, :duration, :integer, :default => 50
  end
end
