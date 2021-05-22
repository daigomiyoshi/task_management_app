class Admin::UserSessionsController < Admin::ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      if @user.admin?
        redirect_to admin_root_path, success: t('.success')
      else
        redirect_to root_path, danger: t('.not_admin_user')
      end
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: t('.success')
  end
end
