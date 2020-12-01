require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) {create(:task)}
  let(:task_doing) {create(:task, :doing)}

  describe "有効性" do
    subject { task } 

    it "タスクは有効" do
      is_expected.to be_valid
    end

    context "タスクが無効な時" do
      it "nameが空なら無効" do
        task.name = nil
        is_expected.to be_invalid
      end

      it "contentが空なら無効" do
        task.content = nil
        is_expected.to be_invalid
      end

      it "nameが51文字以上なら無効" do
        task.name = "a" * 51
        is_expected.to be_invalid
      end
      
      it "contentが201文字以上なら無効" do
        task.content = "a" * 201
        is_expected.to be_invalid
      end

      it "締め切り日が今日よりも前のなら無効" do
        task.deadline -= 10
        is_expected.to be_invalid
      end
    end
  end
  

  describe "検索機能" do
    let(:search_params) { {keyword: "タスク", status: 1} } 

    before do
      task
      task_doing
    end

    subject { Task.search(search_params) } 

    it "ステータスが１のタスクが検索される" do
      is_expected.to include(task)
    end

    it "ステータスが2のタスクは検索されない" do
      is_expected.to_not include(task_doing)
    end

    it "「タスク」が名前に入ってると検索される" do
      is_expected.to include(task)
    end

    it "「タスク」が名前に入ってないと検索されない" do
      task.update_attributes(name: "こんにちは")
      is_expected.to_not include(task)
    end
  end
end
