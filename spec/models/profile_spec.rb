require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { FactoryBot.build(:profile) }
  describe 'ユーザー新規登録' do
    context '成功するとき' do
      it '値が正しいとデータを保存できる' do
        expect(profile).to be_valid
      end
      it 'phoneが空欄でも登録できる' do
        profile.phone = nil
        expect(profile).to be_valid
      end
    end
    context '失敗するとき' do
      it 'nameが空欄だと登録できない' do
        profile.name = nil
        profile.valid?
        expect(profile.errors.full_messages).to include("Name can't be blank")
      end
      it 'groupが空欄だと登録できない' do
        profile.group = nil
        profile.valid?
        expect(profile.errors.full_messages).to include("Group can't be blank")
      end
      it 'userが空欄だと登録できない' do
        profile.user = nil
        profile.valid?
        expect(profile.errors.full_messages).to include("User must exist")
      end
    end
  end
end
