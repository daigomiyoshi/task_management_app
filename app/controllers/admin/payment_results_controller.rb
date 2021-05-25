class Admin::PaymentResultsController < Admin::ApplicationController
  before_action :set_payment_amount, only: %i[show edit update destroy]

  def index
    @payment_results = PaymentResult.all.order(working_month: :desc, project_id: :asc)
  end

  def select_to_create
    @payment_results_candidates = WorkResult.aggregate_monthly_working_results
  end

  def new
    @payment_result = PaymentResult.new(
      user_id: params[:user_id],
      project_id: params[:project_id],
      working_month: params[:working_month],
      payment_amount: params[:payment_amount]
    )
  end
  
  def create
    @payment_result = PaymentResult.new(payment_result_params)
    @payment_result[:payment_note_url] = @payment_result.change_blank_to_nil
    if @payment_result.save
      redirect_to admin_payment_results_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  def show; end

  def edit; end
  
  def update
    if @payment_result.update(payment_result_params)
      redirect_to admin_payment_result_path(@payment_result), success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @payment_result.destroy!
      redirect_to admin_payment_results_path, success: t('.success')
    else
      redirect_to admin_payment_results_path, danger: t('.failure')
    end
  end

  private

  def set_payment_amount
    @payment_result = PaymentResult.find(params[:id])    
  end

  def payment_result_params
    params.require(:payment_result).permit(
      :user_id,
      :project_id,
      :working_month,
      :payment_amount,
      :payment_on,
      :payment_note_url
    )
  end

end
