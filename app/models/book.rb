class Book < ApplicationRecord
  def self.search(search) 
    if search 
      Book.where(["book_title LIKE ?", "%#{search}%"])
    else
      Book.all
    end
  end
end
