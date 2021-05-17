class CreatePaymentResults < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_results do |t|
      t.date :working_month, null: false
      t.integer :payment_amount
      t.date :payment_on
      t.string :payment_note_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
