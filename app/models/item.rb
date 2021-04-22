class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :items_condition
  belongs_to :delivery_charge
  belongs_to :shipping_area
  belongs_to :shipping_date

  belongs_to :user
  has_one_attached :image
  has_one :record

  with_options presence: true do
    validates :image
    validates :name
    validates :information
    validates :price, inclusion: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }, numericality: true
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :items_condition_id
    validates :delivery_charge_id
    validates :shipping_area_id
    validates :shipping_date_id
  end
end
