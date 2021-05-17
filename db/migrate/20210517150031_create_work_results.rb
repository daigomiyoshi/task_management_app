class CreateWorkResults < ActiveRecord::Migration[6.1]
  def change
    create_table :work_results do |t|
      t.date :working_on, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.float :working_hours, default: 0.0
      t.text :working_content
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :project_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
