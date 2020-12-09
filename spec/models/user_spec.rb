require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user) {build(:user)}

    subject { user } 

    shared_examples "ユーザーは有効" do
      it {is_expected.to be_valid}
    end

    shared_examples "ユーザーは無効" do
      it {is_expected.to be_invalid}
    end

    context "全ての要素が有効な時" do
      it_behaves_like "ユーザーは有効"
    end
    
    context "nameが空の時" do
      before {user.name = nil}
      it_behaves_like "ユーザーは無効"
    end

    context "emailが空の時" do
      before {user.email = nil}
      it_behaves_like "ユーザーは無効"
    end

    context "passwordが空の時" do
      let(:user) {build(:user, password: nil, password_confirmation: nil)}
      it_behaves_like "ユーザーは無効"
    end
    
    context "nameが50文字以下の時" do
      before {user.name = "a" * 50}
      it_behaves_like "ユーザーは有効"
    end

    context "nameが51文字以上の時" do
      before {user.name = "a" * 51}
      it_behaves_like "ユーザーは無効"
    end
    context "emailが50文字以下の時" do
      before {user.email = "a" * 41 + "@test.com"}
      it_behaves_like "ユーザーは有効"
    end

    context "emailが51文字以上の時" do
      before {user.email = "a" * 51 + "@test.com"}
      it_behaves_like "ユーザーは無効"
    end

    context "emailが無効な値の時" do
      before {user.email = "test.com"}
      it_behaves_like "ユーザーは無効"
    end

    context "emailが重複してる時" do
      let(:other_user) { create(:user) } 
      before {user.email = other_user.email}
      it_behaves_like "ユーザーは無効"
    end

    context "passwordが5文字以下の時" do
      before do
        user.password = "a" * 5
        user.password_confirmation = "a" * 5
      end
      it_behaves_like "ユーザーは無効"
    end

    context "passwordが6文字以上72文字以下の時" do
      before do
        user.password = "a" * 6
        user.password_confirmation = "a" * 6
      end
      it_behaves_like "ユーザーは有効"
    end

    context "passwordが6文字以上72文字以下の時" do
      before do
        user.password = "a" * 72
        user.password_confirmation = "a" * 72
      end
      it_behaves_like "ユーザーは有効"
    end

    context "passwordが73文字以上の時" do
      before do
        user.password = "a" * 73
        user.password_confirmation = "a" * 73
      end
      it_behaves_like "ユーザーは無効"
    end

    context "passwordとpassword_confirmationが一致しない時" do
      before {user.password_confirmation = "wordpass"}
      it_behaves_like "ユーザーは無効"
    end
  end
end
