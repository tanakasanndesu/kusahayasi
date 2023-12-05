class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t('.update_avatar')
      redirect_to profile_path
    else
      flash.now[:danger] = t('.no_update_avatar')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # params.require(:〇〇)permit(:〇〇)は、情報取得する.必要(モデル).許可(カラム)
  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :avatar_cache)
  end
end
