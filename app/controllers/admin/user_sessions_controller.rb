class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin/layouts/admin_login'
  
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path
      flash[:success] = t('.login_success')
    else
      flash.now[:danger] = t('.login_danger')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('.logout_success')
    redirect_to admin_login_path, status: :see_other
  end
end
