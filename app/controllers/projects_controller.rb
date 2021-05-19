class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end
end
