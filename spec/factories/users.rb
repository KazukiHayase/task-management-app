FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ユーザー#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { "not_admin" }
  end
end
