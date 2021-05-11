FactoryBot.define do
  factory :user do
    name                  {'山田太郎'}
    uid                   {'test'}
    email                 {'test@example.com'}
    password              {'000000'}
    password_confirmation {password}
    occupation_id         {2}
    workplace_id          {2}
    group_id              {2}
  end
end