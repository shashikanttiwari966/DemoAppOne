class CartsController < ApplicationController

  before_action :current_cart
  
  def show_cart
    redirect_to cart_path(@current_cart)
  end

  def show
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to admin_products_path
  end
end
