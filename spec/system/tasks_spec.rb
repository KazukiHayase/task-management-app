require 'rails_helper'

RSpec.describe "Tasks", type: :system do
    before do
        @task1 = create(:task1)
        @task2 = create(:task2)
        @task3 = create(:task3)
    end

    it "タスクが作成日時の降順で並んでいること" do
        visit tasks_path
        task = all(".task")

        expect(task[0].find("h3").text).to eq @task3.name
        expect(task[1].find("h3").text).to eq @task2.name
        expect(task[2].find("h3").text).to eq @task1.name
    end
end
