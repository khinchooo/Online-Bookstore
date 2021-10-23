class Order < ApplicationRecord
  belongs_to :user
  belongs_to :payment, dependent: :destroy
  belongs_to :book
end
