class V1::ProfilesController < ApplicationController
  before_action :authenticate_v1_user!

  def create
    profile = current_v1_user.build_profile(profile_params)
    if profile.save
      render json: { data: current_v1_user.profile }
    else
      render json: ['error': '作成に失敗しました', 'errors_msg': profile.errors.full_messages]
    end
  end

  def show
    render json: { data: current_v1_user.profile }
  end

  def update
    profile = current_v1_user.profile
    if profile.update(profile_params)
      render json: { data: current_v1_user.profile }
    else
      render json: ['error': '編集に失敗しました', 'errors_msg': profile.errors.full_messages]
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :phone, :group, :user_id)
  end
end
