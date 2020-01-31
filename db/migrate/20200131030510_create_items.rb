class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,          null: false
      t.integer :price,        null: false
      t.string :status,        null: false
      t.integer :cost,        null: false
      t.integer :delivery,    null: false
      t.references :brand,     foreign_key: true
      t.boolean :deal,         null: false

      t.timestamps
    end
  end
end
