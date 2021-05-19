class UserAccountsController < ApplicationController
  before_action :set_user_account, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user_account.update(user_account_params)
      redirect_to user_account_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  private

  def set_user_account
    @user_account = UserAccount.find(current_user.id)
  end

  def user_account_params
    params.require(:user_account).permit(
      :bank_name, 
      :bank_branch_name, 
      :bank_branch_code, 
      :bank_account_type, 
      :bank_account_code,
      :bank_account_name
    )
  end
end
