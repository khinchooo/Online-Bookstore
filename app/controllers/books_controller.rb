require 'date'
class BooksController < ApplicationController
  before_action :set_params, only: [:show, :order, :checkout]
  before_action :carts, only: [:create_cart]
  def index
    @books = Book.all.search(params[:search_value]).paginate(page: params[:page], per_page: 8)
  end

  def show
    @current_date = DateTime.now
    @delivery_time = @current_date + 3.days
    @quantity = 1
    @quantity = params[:quantity] unless params[:quantity].blank?
  end

  def order
    # redirect login
    @param_data = params[:book]
    redirect_to new_user_session_path(origin: show_book_path, quantity: @param_data[:quantity]) unless user_signed_in?

    @delivery_time = @param_data[:delivery_time]
    @quantity = @param_data[:quantity]

    # check add_cart
    if @param_data[:add_cart].to_i == 1 && user_signed_in?
      # save cookies
      @carts = []
      cookie_carts = cookies[:carts]
      if cookie_carts.present? && JSON.parse(cookie_carts).length > 0
        @carts = JSON.parse(cookie_carts).find_all {|cart| cart['user_id'].to_i == current_user.id }
      end
      @carts << {
        user_id: current_user.id,
        book_id: @param_data[:book_id],
        quantity: @param_data[:quantity]
      }
      # save cookies
      cookies[:carts] = {
        value: JSON.generate(@carts),
        expires: 1.week
      }
      cookies[:cart_total] = @carts.length
      # redierct
      redirect_to carts_path
    else
      @payment = ['Debit Card', 'Credit Card(Mastercard)', 'Mobile payment', 'Bank transfer']
     
      if @quantity.to_i > 2
        @total_amount = (@book.price * @quantity.to_i)
      else
        @total_amount = (@book.price * @quantity.to_i) + @book.delivery_fee
      end
    end
  end

  def carts
    # get cookies
    cart_list = []
    cookie_carts = cookies[:carts]
    if cookie_carts.present? && JSON.parse(cookie_carts).length > 0
      cart_list = JSON.parse(cookie_carts).find_all {|cart| cart['user_id'].to_i == current_user.id }
    end
    @carts = []
    @sub_total = 0
    cart_list.each do |cart|
      book = Book.find(cart['book_id'])
      if cart['quantity'].to_i > 2
        @total_amount = (book[:price] * cart['quantity'].to_i)
      else
        @total_amount = (book[:price] * cart['quantity'].to_i) + book[:delivery_fee]
      end
      @sub_total += @total_amount
      @delivery_time = DateTime.now + 3.days
      @payment = ['Debit Card', 'Credit Card(Mastercard)', 'Mobile payment', 'Bank transfer']
        @carts << {
        book_id: book[:id],
        book_title: book[:book_title],
        image: book[:image],
        delivery_time: @delivery_time,
        total_amount: @total_amount,
        quantity: cart['quantity'],
        user_id: cart['user_id']
      }
    end
  end

  def create_cart
    payment = Payment.new(
      user_id: params[:user_id],
      payment_type: params[:payment_type]
    )
    if payment.save
      @carts.each do |cart|
        Order.new(
          user_id: cart[:user_id],
          book_id: cart[:book_id],
          quantity: params[:quantity],
          total_amount: cart[:total_amount],
          delivery_time: cart[:delivery_time],
          payment_id: payment[:id]
        ).save
      end
      # index = 0
      # books = Book.find_by(id: params[:book_id])
      # books.each do |book|
      #   Order.new(
      #     book_id: book['book_id'],
      #     quantity: params[:quantity],
      #     total_amount: params[:total_amount],
      #     user_id: params[:user_id],
      #     delivery_time: params[:delivery_time],
      #     payment_id: payment[:id]
      #   ).save
      # end
      # index += 1
      # cookies clear
      cookies[:carts] = []
      cookies[:cart_total] = nil
      redirect_to complete_path
    end
  end

  def cart_remove
    # get cookies
    @carts = []
    cookie_carts = cookies[:carts]
    if cookie_carts.present? && JSON.parse(cookie_carts).length > 0
      @carts = JSON.parse(cookie_carts).find_all {|cart| cart['book_id'].to_i != params[:book_id].to_i}
    end

    # save cookies
    cookies[:carts] = {
      value: JSON.generate(@carts),
      expires: 1.week
    }
    cookies[:cart_total] = @carts.length
    # redierct
    redirect_to carts_path
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
      flash.now[:notice] = "Successful order and payment create."
      redirect_to orders_path 
    else
      flash.now[:alert] = "Create failed!"
      render :order
    end
  end

  def orders
    @order_list = Order.select('
      orders.id,
      orders.book_id,
      orders.created_at,
      orders.delivery_time,
      orders.total_amount,
      orders.quantity,
      payments.payment_type,
      users.name,
      users.address,
      books.image
    ').joins('
      LEFT JOIN payments
      ON payments.id = orders.payment_id
      LEFT JOIN users
      ON users.id = orders.user_id
      LEFT JOIN books
      ON books.id = orders.book_id
    ').where(user_id: current_user.id).order('orders.created_at DESC')
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
      flash.now[:notice] = "Successful update!"
    else
      flash.now[:alert] = "Update failed!"
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
      flash[:notice] = "Order deletion completed successfully."
      redirect_to orders_path
  end

  def complete; end
  
  
  def set_params
    @book = Book.find(params[:id])
  end

  def order_params
    params.require(:do_order).permit(:user_id, :book_id, :quantity, :total_amount, :delivery_time, :order_id, :payment_type)
  end
end
