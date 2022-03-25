class Cart < ApplicationRecord
  # if we destroy a cart, all line items with that cart_id should be destroyed too
  has_many :line_items, dependent: :destroy

  # checks if item being added to cart already exists in cart
  # if yes then increment quantity, if no then create new line item
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end

    current_item
  end
end
