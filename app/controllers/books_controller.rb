require 'date'

class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order, :checkout, :cart]
  def index
    @books = Book.all.search(params[:search_value]).paginate(page: params[:page], per_page: 4)
    @count = 0
  end

  def show
    @current_date = DateTime.now
    @delivery_time = @current_date + 3.days
    @quantity = 1
    @quantity = params[:quantity] unless params[:quantity].blank?
  end

  def order
    # redirect login
    redirect_to new_user_session_path(origin: show_book_path, quantity: params[:book][:quantity]) unless user_signed_in?

    @payment = ['Debit Card', 'Credit Card(Mastercard)', 'Mobile payment', 'Bank transfer']
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
    @payment = Payment.new(
      user_id: current_user.id,
      payment_type: params[:do_order][:payment_type]
    )

    if @payment.save
      Order.new(
        user_id: current_user.id,
        book_id: params[:do_order][:book_id],
        quantity: params[:do_order][:quantity],
        total_amount: params[:do_order][:total_amount],
        delivery_time: params[:do_order][:delivery_time],
        payment_id: @payment[:id]
      ).save

      # redierct
      redirect_to orders_path
    else
      render :order
    end
  end

  def cart
    @book_id = cookies[:book_id] = params[:do_order][:book_id]
    @quantity = cookies[:quantity] = params[:do_order][:quantity]
    @user_id = cookies[:user_id] = current_user.id
    Rails.logger.debug("HERE")
    Rails.logger.debug(@book_id.inspect)
    Rails.logger.debug("HERE")
    Rails.logger.debug(@quantity.inspect)
    Rails.logger.debug("HERE")
    Rails.logger.debug( @user_id.inspect)
  end

  def orders
      @order_list = Order.select('
        orders.id,
        orders.book_id,
        orders.total_amount,
        orders.quantity,
        payments.payment_type,
        users.name,
        users.address
      ').joins('
        INNER JOIN payments
        ON payments.id = orders.payment_id
        INNER JOIN users
        ON users.id = orders.user_id
      ').where(user_id: current_user.id).order('orders.created_at DESC')
  end

  def cart
    cookies[:book_id] = params[:book_id]
  end

  def edit
    @payment = ['Debit Card', 'Credit Card(Mastercard)', 'Mobile payment', 'Bank transfer']
    @order = Order.select('
      orders.id,
      orders.quantity,
      payments.payment_type,
      users.address
    ').joins('
      INNER JOIN payments
      ON payments.id = orders.payment_id
      INNER JOIN users
      ON users.id = orders.user_id
    ').where('orders.id = ?', params[:id]).first
  end

  def update
    @order = Order.find(params[:id])
    @order[:quantity] = params[:quantity]
    @order.payment[:payment_type] = params[:payment_type]
    @order.user[:address] = params[:address]
    if @order.save && @order.payment.save && @order.user.save
      redirect_to orders_path
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_path
  end
  
  def set_params
    @book = Book.find(params[:id])
  end

  def order_params
    params.require(:do_order).permit(:user_id, :book_id, :quantity, :total_amount, :delivery_time, :order_id, :payment_type)
  end
end
