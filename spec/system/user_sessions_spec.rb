require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let!(:user) { create(:user) }
  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        find_button('Login').click
        expect(page).to have_content 'Login successful'
        expect(current_path).to eq root_path
      end
    end
    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        find_button('Login').click
        expect(page).to have_content 'Login failed'
      end
    end
  end

  describe 'ログイン後' do
    before do
      sign_in_as(user)
    end
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        click_on 'Logout'
        expect(page).to have_content 'Logged out'
        expect(current_path).to eq root_path
      end
    end
  end
end