class AddColorToProgram < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :color, :string
  end
end
