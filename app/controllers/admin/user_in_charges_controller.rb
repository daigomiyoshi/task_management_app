class Admin::UserInChargesController < Admin::ApplicationController
  before_action :set_user_in_charge, only: %i[edit update destroy]

  def index
    @user_in_charges = UserInCharge.all.order(project_id: :desc, user_id: :asc)
  end

  def new
    @user_in_charge = UserInCharge.new
  end

  def create
    @user_in_charge = UserInCharge.new(user_in_charge_params)
    if @user_in_charge.save
      redirect_to admin_user_in_charges_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  def edit; end

  def update
    if @user_in_charge.update(user_in_charge_params)
      redirect_to admin_user_in_charges_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @user_in_charge.destroy!
      redirect_to admin_user_in_charges_path, success: t('.success')
    else
      redirect_to admin_user_in_charges_path, danger: t('.failure')
    end
  end

  private

  def set_user_in_charge
    @user_in_charge = UserInCharge.find(params[:id])
  end

  def user_in_charge_params
    params.require(:user_in_charge).permit(:user_id, :project_id, :user_wage)
  end
end
