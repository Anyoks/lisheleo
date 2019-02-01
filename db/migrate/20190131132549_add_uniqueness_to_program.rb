class AddUniquenessToProgram < ActiveRecord::Migration[5.1]
  def change
    add_index :programs, :code, unique: true
    add_index :programs, :color, unique: true 
  end
end
