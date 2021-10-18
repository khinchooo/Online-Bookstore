require 'date'
class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order]
  def index
    @books = Book.all
    @count = 0
  end

  def show
    @book
    @delivery_time = (DateTime.now + 3.days).strftime "%A, %b %d %H:%M"
  end

  def order
    # Get post data
    @param_data = params[:book]
    @quantity = @param_data[:quantity]
    @total_amount = @book.price * @quantity.to_i
  end

  def set_params
    @book = Book.find(params[:id])
  end
end
