class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.integer :total_amount
      t.integer :book_id

      t.timestamps
    end
  end
end
