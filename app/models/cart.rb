class Cart < ApplicationRecord
  # if we destroy a cart, all line items with that cart_id should be destroyed too
  has_many :line_items, dependent: :destroy
end
