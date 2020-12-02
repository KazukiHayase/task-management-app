require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) {create(:task)}

  describe "validations" do

    subject { task } 

    shared_examples "タスクは有効" do
      it {is_expected.to be_valid}
    end

    shared_examples "タスクは無効" do
      it {is_expected.to be_invalid}
    end
    

    context "全ての要素が有効な時" do
      it_behaves_like "タスクは有効"
    end
    
    context "nameが空の時" do
      before {task.name = nil}
      it_behaves_like "タスクは無効"
    end

    context "contentが空の時" do
      before {task.content = nil}
      it_behaves_like "タスクは無効"
    end

    context "nameが50文字以下の時" do
      before {task.name = "a" * 50}
      it_behaves_like "タスクは有効"
    end

    context "nameが51文字以上の時" do
      before {task.name = "a" * 51}
      it_behaves_like "タスクは無効"
    end

    context "contentが200文字以下の時" do
      before {task.content = "a" * 200}
      it_behaves_like "タスクは有効"
    end

    context "contentが201文字以上の時" do
      before {task.content = "a" * 201}
      it_behaves_like "タスクは無効"
    end

    context "deadlineが今日以降の時" do
      before {task.deadline = Date.today}
      it_behaves_like "タスクは有効"
    end

    context "deadlineが今日よりも前の時" do
      before {task.deadline = Date.yesterday}
      it_behaves_like "タスクは無効"
    end
  end
  

  describe "#search" do
    let(:task_doing) {create(:task, :doing)}
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
