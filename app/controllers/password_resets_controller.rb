class PasswordResetsController < ApplicationController
  skip_before_action :require_login, only: %i[new create edit update]  # ログインチェックをスキップ

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    return unless @user

    @user.deliver_reset_password_instructions!
    # パスワードリセット手順を送信
    redirect_to root_path
    flash[:success] = t('.password_change')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      redirect_to login_path
      flash[:success] = t('.password_change_success')
    else
      flash.now[:danger] = t('.password_change_false')
      render :edit, status: :unprocessable_entity
    end
  end
end
