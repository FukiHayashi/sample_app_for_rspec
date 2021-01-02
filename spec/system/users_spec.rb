require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          user_with_all_infomation = build(:user)
          sign_up_as(user_with_all_infomation)
          expect(page).to have_content 'User was successfully created.'
          expect(current_path).to eq login_path
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          user_without_email = build(:user, email: nil)
          sign_up_as(user_without_email)
          user_without_email.errors do |error|
            expect(page).to have_content error
          end
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          user_with_resisterd_email = create(:user)
          sign_up_as(user_with_resisterd_email)
          user_with_resisterd_email.errors do |error|
            expect(page).to have_content error
          end
        end
      end
    end

    describe 'マイページ' do
      let(:user) { create(:user) }
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit user_path(user)
          expect(page).to have_content 'Login required'
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    let(:user) { create(:user) }
    before do
      @user = user
      sign_in_as(@user)
    end
    describe 'ユーザー編集' do
      before do
        visit edit_user_path(@user)
      end
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          @user.email = 'edited@example.com'
          fill_edit_user_info(@user)
          expect(page).to have_content @user.email
          expect(page).to have_content 'User was successfully updated.'
          expect(current_path).to eq user_path(@user)
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          @user.email = nil
          fill_edit_user_info(@user)
          @user.errors do |error|
            expect(page).to have_content error
          end
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          resistered_user = create(:user)
          @user.email = resistered_user.email
          fill_edit_user_info(@user)
          @user.errors do |error|
            expect(page).to have_content error
          end
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          another_user = create(:user)
          visit edit_user_path(another_user)
          expect(page).to have_content 'Forbidden access.'
        end
      end
    end

    describe 'マイページ' do
      let(:task) { create(:task, user: @user) }
      context 'タスクを作成' do
        before do
          @task = task
          visit user_path(@user)
        end
        it '新規作成したタスクが表示される' do
          expect(page).to have_content @task.title
          expect(page).to have_content @task.status.to_s
        end
      end
    end
  end
end
