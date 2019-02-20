class AddDetailsToClient < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :gender, foreign_key: true
    add_column :clients, :dob, :date
    add_column :clients, :id_number, :string
    add_column :clients, :alt_contact, :string
    add_column :clients, :relationship, :string
    add_column :clients, :marital_status, :string
    add_column :clients, :occupation, :string
    add_column :clients, :employer, :string
  end
end
