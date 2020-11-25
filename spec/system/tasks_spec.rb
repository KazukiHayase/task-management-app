require 'rails_helper'

RSpec.describe "Tasks", type: :system do
    let!(:tasks) { create_list(:task, 3) } 
    
    it "タスクが作成日時の降順で並んでいること" do
        visit tasks_path
        tasks_view = all(".task")

        expect(tasks_view[0].find("h3").text).to eq tasks[2].name
        expect(tasks_view[1].find("h3").text).to eq tasks[1].name
        expect(tasks_view[2].find("h3").text).to eq tasks[0].name
    end
end
