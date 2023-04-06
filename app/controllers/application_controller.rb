class ApplicationController < ActionController::Base

  before_action :current_cart

  private

  def current_cart
    # if session[:cart_id]
    #   cart = Cart.find_by(:id => session[:cart_id])
    #   if cart.present?
    #     @current_cart = cart
    #   else
    #     session[:cart_id] = nil
    #   end
    # end

    if current_admin_user.present?
      @current_cart = current_admin_user.cart.present? ? current_admin_user.cart : current_admin_user.create_cart
    elsif session[:cart_id] == nil
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end

  end
end
