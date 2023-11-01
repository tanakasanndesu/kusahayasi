class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path
      flash[:success] = t('.login_success')
    else
      flash[:danger] = t('.login_danger')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('.logout_success')
    redirect_to root_path, status: :see_other
  end
end
