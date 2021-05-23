class Admin::UserAccountsController < Admin::ApplicationController
  before_action :set_user_account, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all.order(:created_at)
  end

  def new
    @user_account = UserAccount.new
    @users = User.eager_load(:user_account).where(user_account: { user_id: nil} )
  end

  def create
    @user_account = UserAccount.new(user_account_params)
    if @user_account.save
      redirect_to admin_user_accounts_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user_account.update(user_account_params)
      redirect_to admin_user_accounts_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @user_account.destroy!
      redirect_to admin_user_accounts_path, success: t('.success')
    else
      redirect_to admin_user_accounts_path, danger: t('.failure')
    end
  end

  private

  def set_user_account
    @user_account = UserAccount.find(params[:id])
  end
  
  def set_user
    @user = User.find(@user_account.user_id)
  end

  def user_account_params
    params.require(:user_account).permit(
      :bank_name, 
      :bank_branch_name, 
      :bank_branch_code, 
      :bank_account_type, 
      :bank_account_code,
      :bank_account_name,
      :user_id
    )
  end
end
