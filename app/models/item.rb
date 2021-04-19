class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :items_condition
  belongs_to :delivery_charge
  belongs_to :shipping_area
  belongs_to :shipping_date

  belongs_to :user
  has_one_attached :image
end
