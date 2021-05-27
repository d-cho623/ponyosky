FactoryBot.define do
  factory :item do
    name { Faker::Name.last_name }
    maker { "株式会社abc" }
    number { 2234 }
    code { 2345 }
    quantity { 2 }
    price { 300 }
    total_price { 600 }
    trading_company { "株式会社bcde" }
    retrieval { "Google" }
    association :user
  end
end
