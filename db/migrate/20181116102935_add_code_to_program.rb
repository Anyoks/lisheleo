class AddCodeToProgram < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :code, :string
  end
end
