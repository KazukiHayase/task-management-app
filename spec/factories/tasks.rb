FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "タスク#{n}" }
    content  { "これはタスクの説明です" }
    sequence(:deadline, Date.today)
  end
end
