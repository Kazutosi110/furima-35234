class RecordPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :items_id, :delivery_postcode, :shipping_area_id, :delivery_municipality, :delivery_address, :delivery_building, :delivery_phone, :record_id
end
