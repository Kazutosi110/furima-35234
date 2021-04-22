class RecordPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :items_id, :delivery_postcode, :shipping_area_id, :delivery_municipality, :delivery_address, :delivery_building, :delivery_phone

  with_options presence: true do
    validates :user_id
    validates :items_id
    validates :delivery_municipality
    validates :delivery_address
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :shipping_area_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :delivery_phone, format: { with: /\A0[0-9]{11}+\z/, message: 'number is invalid. Include half-width numbers' } 
  end

  def save
    Record = Record.create(user_id: user_id, items_id: items_id)
    Purchase.create(delivery_municipality: delivery_municipality, delivery_address: delivery_address, postal_code: postal_code, shipping_area_id: shipping_area_id, delivery_phone: delivery_phone, :delivery_building: delivery_building, record_id: record.id)
  end
end