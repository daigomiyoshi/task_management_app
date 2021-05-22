class Admin::ApplicationController < ApplicationController
  before_action :require_login
  before_action :check_admin
  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, warning: t('message.not_admin_user') unless current_user.admin?
  end
end
