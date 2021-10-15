class BooksController < ApplicationController
  # before_action :set_params, only: [:show, :order]
  def index
    @books = Book.all
    @count = 0
  end

  def show
    @book = Book.find(params[:id])
  end

  def order
    @book = Book.find(params[:id])

    # Get post data
    @param_data = params[:book]
    @quantity = @param_data[:quantity]
    @total_amount = @book.price * @quantity.to_i
  end

  # def set_params
  #   @book = Book.find(params[:id])
  # end
end
