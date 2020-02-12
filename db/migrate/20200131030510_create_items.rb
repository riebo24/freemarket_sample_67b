class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name,         null: false
      t.integer    :price,        null: false
      t.references :category,     null: false, foreign_key: true
      t.text       :status,       null: false
      t.string     :brand
      t.string     :condition,    null: false
      t.string     :cost,         null: false
      t.string     :delivery,     null: false
      t.string     :send_address, null: false
      t.string     :send_date,    null: false
      t.boolean    :deal,         default: false

      t.timestamps
    end
  end
end