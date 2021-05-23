class Admin::ProjectCategoriesController < Admin::ApplicationController
  before_action :set_project
  before_action :set_project_categories, only: %i[index]
  before_action :set_project_category, only: %i[edit update destroy]

  def index; end

  def new
    @project_category = ProjectCategory.new
  end

  def create
    @project_category = ProjectCategory.new(project_category_params)
    if @project_category.save
      redirect_to admin_project_project_categories_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new
    end
  end

  def edit; end

  def update
    if @project_category.update(project_category_params)
      redirect_to admin_project_project_categories_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit
    end
  end

  def destroy
    if @project_category.destroy!
      redirect_to admin_project_project_categories_path, success: t('.success')
    else
      redirect_to admin_project_project_categories_path, failure: t('.failure')
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_categories
    @project_categories = ProjectCategory.where(project_id: params[:project_id])
  end

  def set_project_category
    @project_category = ProjectCategory.find(params[:id])
  end

  def project_category_params
    params.require(:project_category).permit(:project_category_name).merge(project_id: params[:project_id])
  end
end
