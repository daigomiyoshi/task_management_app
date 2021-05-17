class CreateUserAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_accounts do |t|
      t.string :bank_name
      t.string :bank_branch_name
      t.integer :bank_branch_code
      t.integer :bank_account_type, default: 0
      t.integer :bank_account_code
      t.string :bank_account_name

      t.timestamps
    end
  end
end
