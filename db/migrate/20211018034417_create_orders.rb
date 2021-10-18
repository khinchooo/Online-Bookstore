class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :book_id
      t.integer :quantity
      t.timestamps :delivery_time
      t.integer :total_amount

      t.timestamps
    end
  end
end
