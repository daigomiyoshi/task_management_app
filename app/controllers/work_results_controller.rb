class WorkResultsController < ApplicationController
  before_action :set_work_results, only: %i[show_monthly]
  before_action :set_project, only: %i[show_monthly new create]
  before_action :set_project_categories, only: %i[new create]
  before_action :set_year, only: %i[show_monthly new create]
  before_action :set_month, only: %i[show_monthly new create]
  before_action :set_day, only: %i[new create]
  before_action :set_this_day, only: %i[new create]
  before_action :work_result_params, only: %i[create]

  def show_monthly
    @work_results_monthly = @work_results.filter_by_year_month(@year, @month)
    @this_month = Date.parse("#{@year}/#{@month}")
    @beginning_of_month = @this_month.beginning_of_month
    @end_of_month = @this_month.end_of_month
  end

  def new
    @work_result = WorkResult.new
  end

  def create
    @work_result = current_user.work_results.build(work_result_params)
    if @work_result.save
      redirect_to work_result_monthly_path(@project.id, @year, @month), success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  private

  def set_work_results
    @work_results = current_user.work_results.where(project_id: params[:project_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_categories
    @project_categories = ProjectCategory.where(project_id: params[:project_id])
  end

  def set_year
    @year = params[:year]
  end

  def set_month
    @month = params[:month]
  end

  def set_day
    @day = params[:day]
  end

  def set_this_day
    @this_day = Date.parse("#{@year}/#{@month}/#{@day}")
  end

  def work_result_params
    params[:work_result][:working_on] = @this_day
    params[:work_result][:start_at] = Time.parse("#{@year}/#{@month}/#{@day} #{params[:work_result][:start_at]}")
    params[:work_result][:end_at] = Time.parse("#{@year}/#{@month}/#{@day} #{params[:work_result][:end_at]}")
    params[:work_result][:project_id] = @project.id
    params.require(:work_result).permit(
      :working_on, :start_at, :end_at, :working_hours, :working_content, :project_id, :project_category_id
    )
  end
end
