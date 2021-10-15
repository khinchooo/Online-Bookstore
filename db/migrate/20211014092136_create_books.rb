class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :book_title
      t.string :image
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
