FactoryBot.define do
  factory :user do
    name                  {'山田太郎'}
    uid                   {Faker::Name.last_name}
    email                 {Faker::Internet.email}
    password              {'12345678'}
    password_confirmation {password}
    occupation_id         {2}
    workplace_id          {2}
    group_id              {2}
  end
end