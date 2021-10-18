class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :payment_type
      t.integer :order_id
      t.integer :book_id

      t.timestamps
    end
  end
end
