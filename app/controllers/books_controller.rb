require 'date'

class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order, :payment]
  def index
    @books = Book.all
    @count = 0
  end

  def show
    @delivery_time = (DateTime.now.strftime "%A, %b %d")+' ～ '+((DateTime.now + 3.days).strftime "%A, %b %d %H:%M")
  end

  def order
    @payment = ['Debit Card', 'Credit Card', 'Mobile payment', 'Bank transfer']
    # Get post data
    @param_data = params[:book]
    @quantity = @param_data[:quantity]
    if @quantity.to_i > 3
      @total_amount = (@book.price * @quantity.to_i)
    else
      @total_amount = (@book.price * @quantity.to_i) + @book.delivery_fee
    end
  end

  def payment
    # Get post data
    @do_order = params[:do_order]
  end

  def checkout
    # # Get post data
     @do_order = Payment.new(payment_params)
 
    if @do_order.save
      redirect_to '/'
    else 
      render 'payment'
    end
  end

  def set_params
    @book = Book.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:order_id, :book_id, :payment_type)
  end
end
