class RecordPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :delivery_postcode, :shipping_area_id, :delivery_municipality, :delivery_address, :delivery_building, :delivery_phone

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :delivery_municipality
    validates :delivery_address
    validates :delivery_postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :shipping_area_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :delivery_phone, format: {with: /\A\d{10}\z|\A\d{11}\z/ , message: "is invalid."}
  end

  def save
    record = Record.create(user_id: user_id, item_id: item_id)
    Purchase.create(delivery_municipality: delivery_municipality, delivery_address: delivery_address, delivery_postcode: delivery_postcode, shipping_area_id: shipping_area_id, delivery_phone: delivery_phone, delivery_building: delivery_building, record_id: record.id)
  end
end