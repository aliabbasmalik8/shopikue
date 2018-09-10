# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    if(cookies[:add_to_cart])
      JSON.parse(cookies[:add_to_cart]).each do |cookie|
        Order.add_to_cart(cookie["product_id"].to_i,cookie["quantity"].to_i,current_user)
      end
    end
    cookies.delete :add_to_cart
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
