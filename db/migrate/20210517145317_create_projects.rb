class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :project_name, null: false
      t.integer :project_status, default: 1

      t.timestamps
    end
  end
end
