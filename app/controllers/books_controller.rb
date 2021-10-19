require 'date'

class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order, :payment, :checkout]
  def index
    @books = Book.all.paginate(page: params[:page], per_page: 4)
    @count = 0
  end

  def show
    @delivery_time = DateTime.now + 3.days
    # @delivery_time = (DateTime.now.strftime "%A, %b %d")+' ～ '+((DateTime.now + 3.days).strftime "%A, %b %d %H:%M")
  end

  def order
    @payment = ['Debit Card', 'Credit Card', 'Mobile payment', 'Bank transfer']
    @delivery_time = params[:book][:delivery_time]
    # Get post data
    @param_data = params[:book]
    @quantity = @param_data[:quantity]
    if @quantity.to_i > 2
      @total_amount = (@book.price * @quantity.to_i)
    else
      @total_amount = (@book.price * @quantity.to_i) + @book.delivery_fee
    end
  end

  def payment
    # Get post data
    # @do_order = params[:do_order]
  end

  def checkout
    # Get post data
    @order = Order.new(order_params)
    @payment = Payment.new(payment_params)

    if @order.save && @payment.save
      redirect_to '/'
    else 
      render 'payment'
    end
  end

  def set_params
    @book = Book.find(params[:id])
  end

  def order_params
    params.require(:do_order).permit(:book_id, :quantity, :total_amount, :delivery_time)
  end
  def payment_params
    params.require(:do_order).permit(:book_id, :order_id, :payment_type)
  end
end
