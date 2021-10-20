class Payment < ApplicationRecord
  validates :payment_type, presence: true, length: { maximum: 30 }
end
