require 'date'
class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order, :payment]
  def index
    @books = Book.all
    @count = 0
  end

  def show
    @delivery_time = (DateTime.now + 3.days).strftime "%A, %b %d %H:%M"
  end

  def order
    # Get post data
    @param_data = params[:book]
    @quantity = @param_data[:quantity]
    @total_amount = (@book.price * @quantity.to_i) + @book.delivery_fee
  end

  def payment
    #@payment = ['Debit Card', 'Credit Card', 'Mobile payment', 'Bank transfer']
    # Get post data
    @do_order = params[:do_order]
  end

  def checkout
    # @do_order = ['Debit Card', 'Credit Card', 'Mobile payment', 'Bank transfer']
    # # Get post data
    # @do_order = params[:do_order]
  end

  def set_params
    @book = Book.find(params[:id])
  end
end
