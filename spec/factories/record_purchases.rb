FactoryBot.define do
  factory :record_purchase do
    delivery_postcode { '123-4567' }
    shipping_area_id { 40 }
    delivery_municipality { '乃木坂' }
    delivery_address { '46-48' }
    delivery_building { '東京ハイツ' }
    delivery_phone { '09012345678' }
  end
end
