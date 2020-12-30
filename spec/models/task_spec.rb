require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      task = FactoryBot.build(:task)
      expect(task).to be_valid
    end
    it 'is invalid without title' do
      task = FactoryBot.build(:task, title: nil)
      expect(task).to_not be_valid
    end
    it 'is invalid without status' do
      task = FactoryBot.build(:task, status: nil)
      expect(task).to_not be_valid
    end
    it 'is invalid with a duplicate title' do
      FactoryBot.create(:task)
      task = FactoryBot.build(:task)
      expect(task).to_not be_valid
    end
    it 'is valid with another title' do
      FactoryBot.create(:task)
      task = FactoryBot.build(:task, title: 'another title')
      expect(task).to be_valid
    end
    it 'is invalid without user' do
      task = FactoryBot.build(:task, user: nil)
      expect(task).to_not be_valid
    end
  end
end
