class OrderController < ApplicationController
  before_action :set_params, only: [:order]
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
        ON payments.order_id = orders.id
        INNER JOIN users
        ON users.id = orders.user_id
      ').where(user_id: current_user.id).order('orders.created_at DESC')
  end
  def set_params
    @book = Book.find(params[:id])
  end
end
