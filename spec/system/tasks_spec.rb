require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' , type: :doing do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          user_with_all_infomation = FactoryBot.build(:user)
          sign_up_as(user_with_all_infomation)
          expect(page).to have_content 'User was successfully created.'
          expect(current_path).to eq login_path
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          user_without_email = FactoryBot.build(:user, email: nil)
          sign_up_as(user_without_email)
          user_without_email.errors do |error|
            expect(page).to have_content error
          end
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          user_with_resisterd_email = FactoryBot.create(:user)
          sign_up_as(user_with_resisterd_email)
          user_with_resisterd_email.errors do |error|
            expect(page).to have_content error
          end
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do

        end
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do

        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do

        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do

        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do

        end
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される' do

        end
      end
    end
  end
end
