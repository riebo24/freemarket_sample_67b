class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,          null: false
      t.integer :price,        null: false
      t.text :status,        null: false
      t.string :cost,        null: false
      t.string :delivery,    null: false
      t.references :brand,     foreign_key: true
      t.boolean :deal

      t.timestamps
    end
  end
end
