require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) {create(:task)}

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

    it "締め切り日が今日よりも前の時" do
      task.deadline -= 10
      is_expected.to be_invalid
    end
  end
end
