class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :book_id
      t.integer :quantity
      t.datetime :delivery_time
      t.integer :total_amount
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
