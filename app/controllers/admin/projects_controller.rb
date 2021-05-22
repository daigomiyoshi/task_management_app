class Admin::ProjectsController < Admin::ApplicationController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    binding.pry
    @project = Project.new(project_params)
    if @project.save
      redirect_to admin_projects_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to admin_projects_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @project.destroy!
      redirect_to admin_projects_path, success: t('.success')
    else
      redirect_to admin_projects_path, danger: t('.failure')
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:project_name, :project_status)
  end
end
