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
    @do_order = Order.new(
      book_id: params[:book_id],
      quantity: params[:quantity],
      total_amount: params[:total_amount],
      delivery_time: params[:delivery_time]
    )
    if @do_order.save
      redirect_to '/'
    else 
      render 'payment'
    end
  end

  def set_params
    @book = Book.find(params[:id])
  end

  # def payment_params
  #   params.require(:order).permit(:book_id, :quantity, :total_amount)
  # end
end
