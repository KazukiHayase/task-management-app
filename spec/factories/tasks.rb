FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "task#{n}" }
    content  { "これはタスクの説明です" }
  end
end
