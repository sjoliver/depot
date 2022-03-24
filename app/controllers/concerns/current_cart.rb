module CurrentCart
  # private prevents Rails from making the set_cart method available as an action on the controller
  private

  # looks to find a cart given a cart_id in the session
  # if no cart is found, an exception is raised and a new cart is created 
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
