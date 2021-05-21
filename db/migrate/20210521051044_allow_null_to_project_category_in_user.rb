class AllowNullToProjectCategoryInUser < ActiveRecord::Migration[6.1]
  def change
    change_column_null :work_results, :project_category_id, true
  end
end
