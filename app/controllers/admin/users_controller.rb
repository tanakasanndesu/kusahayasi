class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t('.update_user')
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = t('.no_update_user')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    flash[:success] = t('.destroy_user')
    redirect_to admin_users_path, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :avatar_cache, :role)
  end
end
