class Addreference < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :seller, foreign_key: { to_table: :users }
    add_reference :items, :buyer, foreign_key: { to_table: :users }
  end
end
