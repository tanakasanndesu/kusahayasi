class Admin::BaseController < ApplicationController
    before_action :check_admin
    layout 'admin/layouts/application'
private
    def not_authenticated
        redirect_to admin_login_path
        flash[:danger] = "ログインしてください"
    end

    def check_admin
        redirect_to root_path, warning: "権限がありません" unless current_user.admin?
    end
end
