require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryBot.build(:project) }
  describe 'ユーザー新規登録' do
    context '成功するとき' do
      it '値が正しいとデータを保存できる' do
        expect(project).to be_valid
      end
      it 'urlが空欄でも登録できる' do
        project.url = nil
        expect(project).to be_valid
      end
    end
    context '失敗するとき' do
      it 'titleが空欄だと登録できない' do
        project.title = nil
        project.valid?
        expect(project.errors.full_messages).to include("Title can't be blank")
      end
      it 'titleが空欄だと登録できない' do
        project.title = 'a' * 51
        project.valid?
        expect(project.errors.full_messages).to include('Title is too long (maximum is 50 characters)')
      end
      it 'categoryが空欄だと登録できない' do
        project.category = nil
        project.valid?
        expect(project.errors.full_messages).to include("Category can't be blank")
      end
      it 'deadlineが空欄だと登録できない' do
        project.deadline = nil
        project.valid?
        expect(project.errors.full_messages).to include("Deadline can't be blank")
      end
    end
  end
end
