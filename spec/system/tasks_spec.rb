require 'rails_helper'

RSpec.describe "Tasks", type: :system do
    before do
        @task1 = Task.create!(name: "タスク1", content: "タスク1です")
        @task2 = Task.create!(name: "タスク2", content: "タスク2です")
        @task3 = Task.create!(name: "タスク3", content: "タスク3です")
    end

    it "タスクが作成日時の降順で並んでいること" do
        visit tasks_path
        task = all(".task")

        expect(task[0].find("h3").text).to eq "タスク3"
        expect(task[1].find("h3").text).to eq "タスク2"
        expect(task[2].find("h3").text).to eq "タスク1"
    end
end
