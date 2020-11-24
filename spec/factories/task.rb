FactoryBot.define do
  factory :task1, class: Task do
    name { "タスク1" }
    content  { "タスク1です" }
  end

  factory :task2, class: Task do
    name { "タスク2" }
    content  { "タスク2です" }
  end

  factory :task3, class: Task do
    name { "タスク3" }
    content  { "タスク3です" }
  end
end