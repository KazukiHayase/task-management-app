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

    describe "name" do
      before do
        user.name = name
      end
      
      context "nameが空の時" do
        let(:name) { nil } 
        it_behaves_like "ユーザーは無効"
      end

      context "nameが50文字以下の時" do
        let(:name) { "a" * 50 } 
        it_behaves_like "ユーザーは有効"
      end

      context "nameが51文字以上の時" do
        let(:name) { "a" * 51 } 
        it_behaves_like "ユーザーは無効"
      end
    end
    
    describe "email" do
      before do
        user.email = email
      end
      
      context "emailが空の時" do
        let(:email) { nil } 
        it_behaves_like "ユーザーは無効"
      end

      context "emailが50文字以下の時" do
        let(:email) { "a" * 41 + "@test.com" }
        it_behaves_like "ユーザーは有効"
      end

      context "emailが51文字以上の時" do
        let(:email) { "a" * 51 + "@test.com" }
        it_behaves_like "ユーザーは無効"
      end

      context "emailが無効な値の時" do
        let(:email) { "test.com" }
        it_behaves_like "ユーザーは無効"
      end

      context "emailが重複してる時" do
        let(:other_user) { create(:user) } 
        let(:email) { other_user.email }
        it_behaves_like "ユーザーは無効"
      end
    end
    
    describe "password" do
      before do
        user.password = password
        user.password_confirmation = password
      end
      
      context "passwordが空の時" do
        let(:password) { nil } 
        it_behaves_like "ユーザーは無効"
      end

      context "passwordが5文字以下の時" do
        let(:password) {"a" * 5}
        it_behaves_like "ユーザーは無効"
      end

      context "passwordが6文字以上72文字以下の時" do
        let(:password) {"a" * 6}
        it_behaves_like "ユーザーは有効"
      end

      context "passwordが6文字以上72文字以下の時" do
        let(:password) {"a" * 72}
        it_behaves_like "ユーザーは有効"
      end

      context "passwordが73文字以上の時" do
        let(:password) {"a" * 73}
        it_behaves_like "ユーザーは無効"
      end

      context "passwordとpassword_confirmationが一致しない時" do
        let(:password) { "password" } 
        before {user.password_confirmation = "wordpass"}
        it_behaves_like "ユーザーは無効"
      end
    end
  end
end
