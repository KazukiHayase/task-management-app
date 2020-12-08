FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "タスク#{n}" }
    content  { "これはタスクの説明です" }
    sequence(:deadline, Date.today)
    status { :not_started }
    priority { :middle }

    trait :doing do
      status { :doing }
    end

    trait :done do
      status { :done }
    end

    trait :low do
      priority { :low }
    end

    trait :high do
      priority { :high }
    end
  end
end
