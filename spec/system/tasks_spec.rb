require 'rails_helper'

RSpec.describe "Tasks", js: true, type: :system do
    let(:user) { create(:user) } 
    let(:tasks) { create_list(:task, 3) } 
    let(:task_doing) { create(:task, :doing) } 
    let(:task_done) { create(:task, :done) } 
    let(:task_low) { create(:task, :low) } 
    let(:task_high) { create(:task, :high) } 
    

    describe "ソート機能" do
        before do
            login user
            tasks
            visit tasks_path
        end

        subject { first(".task_item .name") }
        
        it "タスクが作成日時の降順で並んでいること" do
            is_expected.to have_content tasks[2].name
        end

        context "締め切り日の昇順でソートした時" do
            before {sort("締め切り日が近い順")}
            it {is_expected.to have_content tasks[0].name}
        end

        context "締め切り日の降順でソートした時" do
            before {sort("締め切り日が遠い順")}
            it {is_expected.to have_content tasks[2].name}
        end

        context "優先順位の昇順でソートした時" do
            before do
                task_low
                sort("優先順位が低い順")
            end 
            it {is_expected.to have_content task_low.name}
        end

        context "優先順位の降順でソートした時" do
            before do
                task_high
                sort("優先順位が高い順")
            end
            it {is_expected.to have_content task_high.name}
        end
    end

    describe "検索機能" do
        before do
            login user
            tasks
            task_doing
            task_done
            visit tasks_path
        end

        subject { page } 

        context "ステータスで検索した時" do
            before do 
                select("着手中", from: "status")
                click_button "検索"
            end
            it {is_expected.to  have_content task_doing.name}
        end

        context "タイトルで検索した時" do
            before do
                fill_in("キーワード", with: "タスク")
                click_button "検索"
            end
            it {is_expected.to  have_content tasks[0].name}
        end

        context "ステータスとタイトルで検索した時" do
            before do
                select("完了", from: "status")
                fill_in("キーワード", with: "タスク")
                click_button "検索"
            end
            it {is_expected.to  have_content task_done.name}
        end
    end
end
