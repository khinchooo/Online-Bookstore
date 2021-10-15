class BooksController < ApplicationController
  def index
    @books = Book.all
    @count = 0
  end
end
