class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string     :delivery_postcode,          null: false
      t.integer    :shipping_area_id,           null: false
      t.string     :delivery_municipality,      null: false
      t.string     :delivery_address,           null: false
      t.string     :delivery_building
      t.string     :delivery_phone,             null: false
      t.references :record,                     null: false, foreign_key: true
      t.timestamps
    end
  end
end
