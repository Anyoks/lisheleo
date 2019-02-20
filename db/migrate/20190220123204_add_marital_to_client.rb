class AddMaritalToClient < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :marital, foreign_key: true
  end
end
