require 'rails_helper'

RSpec.describe "Tasks", js: true, type: :system do
    let(:tasks) { create_list(:task, 3) } 
    let(:task_doing) { create(:task, :doing) } 
    let(:task_done) { create(:task, :done) } 
    

    describe "ソート機能" do
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

    describe "検索機能" do
        before do
            tasks
            task_doing
            task_done
            visit tasks_path
        end

        subject { page } 

        it "ステータスで検索" do
            select("着手中", from: "status")
            is_expected.to  have_content task_doing.name
        end

        it "タイトルで検索" do
            fill_in("キーワード", with: "タスク")
            is_expected.to  have_content tasks[0].name
        end

        it "ステータスとタイトルで検索" do
            select("完了", from: "status")
            fill_in("キーワード", with: "タスク")
            is_expected.to  have_content task_done.name
        end
    end
end
