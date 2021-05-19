class WorkResultsController < ApplicationController
  before_action :set_work_results, only: %i[show_monthly]
  before_action :set_project, only: %i[show_monthly]
  before_action :set_year, only: %i[show_monthly]
  before_action :set_month, only: %i[show_monthly]

  def show_monthly
    @work_results_monthly = @work_results.filter_by_year_month(@year, @month)
    @this_month = Date.parse("#{@year}/#{@month}")
    @beginning_of_month = @this_month.beginning_of_month
    @end_of_month = @this_month.end_of_month
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_work_results
    @work_results = current_user.work_results.where(project_id: params[:project_id])
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
end
