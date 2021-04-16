FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { "abab22" }
    password_confirmation { password }
    last_name             { "漢ひらカタ" }
    first_name            { "字がなカナ" }
    kana_last             { "ゼンカク" }
    kana_first            { "カタカナ" }
    birthday              { Faker::Date.backward }
  end
end
