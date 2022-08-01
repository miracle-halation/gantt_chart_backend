class V1::ProjectsController < ApplicationController
	def index
		projects = Project.all()
		render json: projects
	end

	def create
		project = Project.new(project_params)
		if project.save
			render json: project
		else
			render json: ['error': '作成に失敗しました', 'errors_msg': project.errors.full_messages]
		end
	end

	private
	def project_params
		params.require(:project).permit(:title, :category, :url, :deadline, :group_id)
	end
end
