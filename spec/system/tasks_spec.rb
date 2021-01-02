require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
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
      context 'タスクの一覧ページに遷移' do
        it '全てのユーザのタスク情報が表示される' do
          task_list = create_list(:task, 3)
          visit tasks_path
          expect(page).to have_content task_list[0].title
          expect(page).to have_content task_list[1].title
          expect(page).to have_content task_list[2].title
          expect(current_path).to eq tasks_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      sign_in_as(user)
    end
    describe 'タスク新規登録' do
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
      context 'タイトルが未入力' do
        it 'タスクの新規作成が失敗する' do
          task_without_title = build(:task, title: nil)
          deadline = DateTime.current
          visit new_task_path
          fill_task_form_info(task_without_title, deadline)
          expect(page).to have_content '1 error prohibited this task from being saved:'
          expect(page).to have_content "Title can't be blank"
          expect(current_path).to eq tasks_path
       end
     end
     context '登録済のタイトルを入力' do
       it 'タスクの新規作成が失敗する' do
         visit new_task_path
         other_task = create(:task)
         deadline = DateTime.current
         task_with_resistered_title = build(:task, title: other_task.title)
         fill_task_form_info(task_with_resistered_title, deadline)
         expect(page).to have_content '1 error prohibited this task from being saved'
         expect(page).to have_content 'Title has already been taken'
         expect(current_path).to eq tasks_path
       end
     end
    end

    describe 'タスク編集' do
      let!(:task) { create(:task, user: user) }
      let(:other_task) { create(:task, user: user) }
      before do
        visit edit_task_path(task)
      end
      context 'フォームの入力値が正常' do
        it 'タスクが編集できること' do
          edited_task = build(:task, title: 'Edited title',
                                     content: 'Edited content',
                                     status: :done,
                                     user: user)
          fill_edit_task_form_info(edited_task)
          expect(page).to have_content 'Task was successfully updated.'
          expect(page).to have_content edited_task.title
          expect(page).to have_content edited_task.content
          expect(page).to have_content edited_task.status.to_s
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの編集が失敗する' do
          task_without_title = build(:task, title: nil)
          fill_edit_task_form_info(task_without_title)
          expect(page).to have_content '1 error prohibited this task from being saved'
          expect(page).to have_content "Title can't be blank"
          expect(current_path).to eq task_path(task)
        end
      end
      context '登録済のタイトルを入力' do
        it 'タスクの編集が失敗する' do
          task_with_resistered_title = build(:task, title: other_task.title)
          fill_edit_task_form_info(task_with_resistered_title)
          expect(page).to have_content '1 error prohibited this task from being saved'
          expect(page).to have_content "Title has already been taken"
          expect(current_path).to eq task_path(task)
        end
      end
    end

    describe 'タスク削除' do
      let!(:task) { create(:task, user: user) }
      it 'タスクの削除が成功する' do
        visit tasks_path
        click_link 'Destroy'
        expect(page.accept_confirm).to eq 'Are you sure?'
        expect(page).to have_content 'Task was successfully destroyed'
        expect(current_path).to eq tasks_path
        expect(page).not_to have_content task.title
      end
    end

    describe 'タスク詳細ページ' do
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
end
