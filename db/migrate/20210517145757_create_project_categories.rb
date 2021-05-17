class CreateProjectCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :project_categories do |t|
      t.string :project_category_name, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
