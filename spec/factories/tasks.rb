FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "タスク#{n}" }
    content  { "これはタスクの説明です" }
    sequence(:deadline, Date.today)
    status {1}

    trait :doing do
      status{2}
    end

    trait :done do
      status{3}
    end
  end
end
