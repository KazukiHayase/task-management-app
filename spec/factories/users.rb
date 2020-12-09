FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    remember_token { "MyString" }
    admin { false }
  end
end
