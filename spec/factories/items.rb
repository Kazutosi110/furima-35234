FactoryBot.define do
  factory :item do
    name                  {Faker::Commerce.name}
    information           {Faker::Lorem.sentence}
    category_id           {"5"}          
    items_condition_id    {"4"}  
    delivery_charge_id    {"3"} 
    shipping_area_id      {"36"}
    shipping_date_id      {"2"}
    price                 {"8_888"}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
