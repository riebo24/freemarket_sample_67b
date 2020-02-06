class Addreferenc < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :send_address, :string, null: false
    add_column :items, :send_date, :string, null: false
    add_column :items, :condition, :string, null: false
  end
end
