require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      task_with_all_attributes = build(:task)
      expect(task_with_all_attributes).to be_valid
      expect(task_with_all_attributes.errors).to be_empty
    end

    it 'is invalid without title' do
      task_without_title = build(:task, title: nil)
      expect(task_without_title).to_not be_valid
      expect(task_without_title.errors).to_not be_empty
    end

    it 'is invalid without status' do
      task_without_status = build(:task, status: nil)
      expect(task_without_status).to_not be_valid
      expect(task_without_status.errors).to_not be_empty
    end

    it 'is invalid with a duplicate title' do
      task = create(:task, title: 'duplicate_title')
      task_with_duplicate_title = build(:task, title: task.title)
      expect(task_with_duplicate_title).to_not be_valid
      expect(task_with_duplicate_title.errors).to_not be_empty
    end

    it 'is valid with another title' do
      create(:task)
      task_with_anoter_title = build(:task, title: 'another title')
      expect(task_with_anoter_title).to be_valid
      expect(task_with_anoter_title.errors).to be_empty
    end

    it 'is invalid without user' do
      task_without_user = build(:task, user: nil)
      expect(task_without_user).to_not be_valid
      expect(task_without_user.errors).to_not be_empty
    end
  end
end
