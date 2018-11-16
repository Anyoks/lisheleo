class AddDurationToProgram < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :duration, :integer
  end
end
