require 'date'

class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order, :checkout]
  def index
    @books = Book.all.search(params[:search_value]).paginate(page: params[:page], per_page: 4)
    @count = 0
  end

  def show
    @current_date = DateTime.now
    @delivery_time = @current_date + 3.days
  end

  def order
    # redirect login
    redirect_to new_user_session_path(origin: show_book_path) unless user_signed_in?

    @payment = ['Debit Card', 'Credit Card', 'Mobile payment', 'Bank transfer']
    @delivery_time = params[:book][:delivery_time]
    @param_data = params[:book]
    @quantity = @param_data[:quantity]
    if @quantity.to_i > 2
      @total_amount = (@book.price * @quantity.to_i)
    else
      @total_amount = (@book.price * @quantity.to_i) + @book.delivery_fee
    end
  end

  def checkout
    # Get post data
    @order = Order.new(
      book_id: params[:do_order][:book_id],
      quantity: params[:do_order][:quantity],
      total_amount: params[:do_order][:total_amount],
      delivery_time: params[:do_order][:delivery_time]
    )

    if @order.save
      Payment.new(
        book_id: params[:do_order][:book_id],
        order_id: @order.id,
        payment_type: params[:do_order][:payment_type]
      ).save

      # redierct
      redirect_to orders_path
    else
      render :order
    end
  end

  def orders
    @order_list = Order.select('
      orders.book_id,
      orders.total_amount,
      orders.quantity,
      payments.payment_type
    ').joins('INNER JOIN payments ON payments.order_id = orders.id')
  end
  

  def set_params
    @book = Book.find(params[:id])
  end

  def order_params
    params.require(:do_order).permit(:book_id, :quantity, :total_amount, :delivery_time, :order_id, :payment_type)
  end
end
