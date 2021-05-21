class WorkResultsController < ApplicationController
  helper_method :get_work_result_info, 
                :render_working_status, 
                :render_edit_or_create_without_work_button,
                :render_show_button
  before_action :set_project, only: %i[show_monthly new create creat_without_work show edit update destroy]
  before_action :set_project_categories, only: %i[new create edit]
  before_action :set_year, only: %i[show_monthly new create creat_without_work show edit update destroy]
  before_action :set_month, only: %i[show_monthly new create creat_without_work show edit update destroy]
  before_action :set_day, only: %i[new create creat_without_work show edit update destroy]
  before_action :set_this_day, only: %i[new create creat_without_work show edit update destroy]
  before_action :set_work_results, only: %i[show_monthly]
  before_action :set_work_result, only: %i[show edit update destroy]
  before_action :set_project_category_name, only: %i[show]
  before_action :work_result_params, only: %i[create update]

  def show_monthly
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

  def creat_without_work
    @work_result = current_user.work_results.build(
      project_id: @project.id,
      project_category_id: nil,
      working_on: @this_day,
      start_at: Time.parse("#{@this_day} 00:00"),
      end_at: Time.parse("#{@this_day} 00:00"),
      working_hours: 0.0
    )
    if @work_result.save
      redirect_to work_result_monthly_path(@project.id, @year, @month), success: t('.success')
    end
  end

  def show; end

  def edit; end

  def update
    if @work_result.update(work_result_params)
      redirect_to work_result_monthly_path(@project.id, @year, @month), success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  def destroy
    @work_result.destroy!
    redirect_to work_result_monthly_path(@project.id, @year, @month), success: t('.success')
  end

  private

  def get_work_result_info(project_id, year, month, day, type)
    @work_result = @work_results.filter_by_year_month_day(year, month, day)[0]
    if type == 'start_at'
      @work_result.nil? ? '00:00' : I18n.l(@work_result.start_at, format: :hour_minutes)
    elsif type == 'working_hours'
      @work_result.nil? ? '0.0' : @work_result.working_hours.to_s
    end
  end

  def render_working_status(year, month, day)
    if @work_result.nil?
      "
        <a class='btn btn-info btn-block' href='/projects/#{@project.id}/#{year}/#{month}/#{day}/new'>
          #{t('.create_work_result')}
        </a>
      ".html_safe
    else
      "
        <button type='button' class='btn btn-secondary btn-block' disabled>
          #{t('.work_result_fixed')}
        </button>
      ".html_safe
    end
  end

  def render_edit_or_create_without_work_button(year, month, day)
    if @work_result.nil?
      "
        <a class='btn btn-info btn-block' data-method='post'
          href='/projects/#{@project.id}/#{year}/#{month}/#{day}/creat_without_work'>
          #{t('.create_work_result_without_work')}
        </a>
      ".html_safe
    else
      "
        <a class='btn btn-outline-secondary btn-block' href='/projects/#{@project.id}/#{year}/#{month}/#{day}/edit'>
          #{t('.edit_work_result')}
        </a>
      ".html_safe
    end
  end

  def render_show_button(year, month, day)
    if !@work_result.nil?
      "
        <a href='/projects/#{@project.id}/#{year}/#{month}/#{day}'>
          <i class='fas fa-external-link-alt' style='color: #000'></i>
        </a>
      ".html_safe
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_categories
    @project_categories = ProjectCategory.where(project_id: @project)
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

  def set_work_results
    @work_results = current_user.work_results.where(project_id: @project)
  end

  def set_work_result
    @work_result = current_user.work_results.find_by(project_id: @project, working_on: @this_day)
  end

  def set_project_category_name
    if @work_result.project_category_id.nil?
      @project_category_name = ''
    else
      @project_category_name = ProjectCategory.find(@work_result.project_category_id).project_category_name
    end
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
