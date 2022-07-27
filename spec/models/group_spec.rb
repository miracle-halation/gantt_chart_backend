require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { FactoryBot.build(:group) }
  context '成功するとき' do
    it '値が正しいとデータを保存できる' do
      expect(group).to be_valid
    end
  end
  context '失敗するとき' do
    it 'nameが空欄だと登録できない' do
      group.name = ''
      group.valid?
      expect(group.errors.full_messages).to include("Name can't be blank")
    end
    it 'nameが51文字以上だと登録できない' do
      group.name = 'a' * 51
      group.valid?
      expect(group.errors.full_messages).to include('Name is too long (maximum is 50 characters)')
    end
  end
end
