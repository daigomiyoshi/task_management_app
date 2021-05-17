class CreateUserInCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_in_charges do |t|
      t.integer :user_wage, null: false
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
