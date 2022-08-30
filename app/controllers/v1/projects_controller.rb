class V1::ProjectsController < ApplicationController
  before_action :authenticate_v1_user!
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    projects = Project.all
    render json: projects
  end

  def create
    project = Project.new(project_params)
    if project.save
      render json: { data: project }
    else
      render json: ['error': '作成に失敗しました', 'errors_msg': project.errors.full_messages]
    end
  end

  def show
    render json: { data: @project }
  end

  def update
    if @project.update(project_params)
      render json: { data: @project }
    else
      render json: ['error': '更新に失敗しました', 'errors_msg': @project.errors.full_messages]
    end
  end

  def destroy
    @project.destroy
    render json: ['success': 'プロジェクトを削除しました']
  end

  private

  def project_params
    params.require(:project).permit(:title, :category, :url, :deadline).merge(user_ids: params[:user_ids])
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
