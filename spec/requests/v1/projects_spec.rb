require 'rails_helper'

RSpec.describe "V1::Projects", type: :request do
  let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'testtest') }
  let!(:auth_headers) { login(user) }
  describe "GET index /v1/projects" do
    let!(:project_list) { FactoryBot.create_list(:project, 10) }
    context '成功する時' do
      it 'projectを全て取得できる' do
        get v1_projects_path, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json.count).to eq 10
      end
    end
  end
  describe "Post create /v1/projects/:id" do
    context '成功する時' do
      it '値が正しいとprojectを作成できる' do
        post_params = { project: {title: 'test_project', category: 'システム開発', url: 'test.domain.com', deadline: '2022-12-31'}, user_ids: [user.id] }
        post v1_projects_path, params: post_params, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['data']['title']).to eq post_params[:project][:title]
      end
    end
    context '失敗する時' do
      it '値が間違っている時に作成に失敗してエラーを返すする' do
        post_params = { project: {title: '', category: 'システム開発', url: 'test.domain.com', deadline: '2022-12-31'}, user_ids: [user.id] }
        post v1_projects_path, params: post_params, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]['error']).to eq '作成に失敗しました'
        expect(json[0]['errors_msg']).to include("Title can't be blank")
      end
    end
  end
  describe "Get show /v1/projects/:id" do
    let!(:project) { FactoryBot.create(:project) }
    context '成功する時' do
      it 'idが一致したら値を取得し、jsonで返す' do
        post_params = {id: project.id}
        get v1_projects_path, params: post_params, headers: auth_headers
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json[0]['id']).to eq project.id
      end
    end
  end
end
