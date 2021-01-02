require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let!(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  describe 'ログイン前' do
    context 'タスクの新規作成ページに遷移' do
      it '遷移できないこと' do
        visit new_task_path
        expect(page).to have_content 'Login required'
        expect(current_path).to eq login_path
      end
    end
    context 'タスクの編集ページに遷移' do
      it '遷移できないこと' do
        visit edit_task_path(task)
        expect(page).to have_content 'Login required'
        expect(current_path).to eq login_path
      end
    end
    context 'タスクの詳細ページに遷移' do
      it 'タスクの詳細が表示されること' do
        visit task_path(task)
        expect(page).to have_content task.title
        expect(page).to have_content task.content
        expect(page).to have_content task.status.to_s
        expect(page).to have_content task.deadline.strftime('%Y/%-m/%-d %-H:%-M')
      end
    end
  end

  describe 'ログイン後' do
    before do
      sign_in_as(user)
    end
    context 'タスクの新規作成ページに遷移' do
      it 'タスクが作成できること' do
        new_task = build(:task, user: user)
        deadline = DateTime.current
        visit new_task_path
        fill_task_form_info(new_task, deadline)

        expect(page).to have_content 'Task was successfully created.'
        expect(page).to have_content new_task.title
        expect(page).to have_content new_task.content
        expect(page).to have_content new_task.status.to_s
        expect(page).to have_content deadline.strftime('%Y/%-m/%-d %-H:%-M')
      end
    end
    context 'タスクの編集ページに遷移' do
      it 'タスクが編集できること' do
        edited_task = build(:task, title: 'Edited title',
                                   content: 'Edited content',
                                   status: :done,
                                   user: user)
        visit edit_task_path(task)
        fill_edit_task_form_info(edited_task)
        expect(page).to have_content 'Task was successfully updated.'
        expect(page).to have_content edited_task.title
        expect(page).to have_content edited_task.content
        expect(page).to have_content edited_task.status.to_s
      end
    end
    context 'タスクの詳細ページに遷移' do
      it 'タスクの詳細が表示されること' do
        visit task_path(task)
        expect(page).to have_content task.title
        expect(page).to have_content task.content
        expect(page).to have_content task.status.to_s
        expect(page).to have_content task.deadline.strftime('%Y/%-m/%-d %-H:%-M')
      end
    end
  end
end
