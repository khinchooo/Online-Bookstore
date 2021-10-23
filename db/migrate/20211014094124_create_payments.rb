class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :payment_type
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
