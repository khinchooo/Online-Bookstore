class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :book, null: false, foreign_key: true
      t.integer :quantity
      t.datetime :delivery_time
      t.integer :total_amount
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: true, foreign_key: true
      t.timestamps
    end
  end
end
