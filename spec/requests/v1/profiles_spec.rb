require 'rails_helper'

RSpec.describe 'V1::Profiles', type: :request do
  let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'testtest') }
  let!(:auth_headers) { login(user) }
  describe 'Get /v1/profiles' do
    let!(:profile) { FactoryBot.create(:profile, user_id: user.id) }
    context '成功する時' do
      it 'ログインしているユーザーのprofileを取得できる' do
        get v1_profiles_path, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['data']['id']).to eq profile.id
        expect(json['data']['user_id']).to eq profile.user.id
      end
    end
  end
  describe 'Post /v1/profiles' do
    context '成功する時' do
      it '値が正しい時に作成に成功する' do
        post_params = { profile: { name: 'test_create', phone: '000-1111-1111', group: 'システム部' } }
        expect {post v1_profiles_path, params: post_params, headers: auth_headers}.to change(Profile, :count).by(1)
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['data']['name']).to eq post_params[:profile][:name]
      end
    end
    context '失敗する時' do
      it '値が間違っている時に作成に失敗してエラーを返す' do
        post_params = { profile: { name: '', phone: '000-1111-1111', group: '' } }
        expect {post v1_profiles_path, params: post_params, headers: auth_headers}.to change(Profile, :count).by(0)
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]['error']).to eq '作成に失敗しました'
        expect(json[0]['errors_msg']).to include("Name can't be blank")
        expect(json[0]['errors_msg']).to include("Group can't be blank")
      end
    end
  end
  describe "Put /v1/profiles" do
    let!(:profile) { FactoryBot.create(:profile, name: 'test_old', user_id: user.id) }
    context "成功する時" do
      it "値が正しい時にprofileを更新することができる" do
        post_params = { profile: { name: 'test_update', phone: '000-1111-0000', group: '企画部' } }
        put v1_profiles_path, params: post_params, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['data']['name']).not_to eq profile.name
        expect(json['data']['name']).to eq post_params[:profile][:name]
      end
    end
    context "失敗する時" do
      it "値が間違っている時にprofileの更新に失敗してエラーメッセージを返す" do
        post_params = { profile: { name: '', phone: '000-1111-0000', group: '' } }
        put v1_profiles_path, params: post_params, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]['error']).to eq '編集に失敗しました'
        expect(json[0]['errors_msg']).to include("Name can't be blank")
        expect(json[0]['errors_msg']).to include("Group can't be blank")
      end
    end
  end
end
