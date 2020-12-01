require 'rails_helper'

RSpec.describe "Tasks", js: true, type: :system do
    let(:tasks) { create_list(:task, 3) } 
    

    describe "タスク一覧画面でソート" do
        before do
            tasks
            visit tasks_path
        end

        subject { first(".task_item .name") }
        
        it "タスクが作成日時の降順で並んでいること" do
            is_expected.to have_content tasks[2].name
        end

        it "タスクが締め切り日の昇順で並んでいること" do
            sort("締め切り日が近い順")
            is_expected.to have_content tasks[0].name
        end

        it "タスクが締め切り日の降順で並んでいること" do
            sort("締め切り日が遠い順")
            is_expected.to have_content tasks[2].name
        end
    end
end
