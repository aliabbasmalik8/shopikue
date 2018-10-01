# frozen_string_literal: true

# payment controller
class PaymentsController < ApplicationController
  def new
    @amount = Payment.total_amount(current_user.id)
    @widgets_count = Payment.widgets_count(current_user.id)
    @email = current_user.email
  end

  def create
    # Amount in cents
    @amount = Payment.total_amount(current_user.id) * 100
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source:  params[:stripeToken]
    )
    @charge = Stripe::Charge.create(
      customer:   customer.id,
      amount:     @amount,
      description: 'Rails Stripe customer',
      currency:   'usd'
    )
    if @charge.paid
      Payment.update_order_status(current_user.id, @amount / 100)
      initialize_params
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def initialize_params
    @email = params[:stripeEmail]
    initialize_billing_address
    initialize_shipping_address
  end

  def initialize_billing_address
    @billing_name = params[:stripeBillingName]
    @billing_country = params[:stripeBillingAddressCountry]
    @billing_country_code = params[:stripeBillingAddressCountryCode]
    @billing_address_zip_code = params[:stripeBillingAddressZip]
    @billing_address = params[:stripeBillingAddressLine1]
    @billing_state = params[:stripeBillingAddressCity]
    @billing_city = params[:stripeBillingAddressState]
  end

  def initialize_shipping_address
    @shipping_name = params[:stripeShippingName]
    @shipping_country = params[:stripeShippingAddressCountry]
    @shipping_country_code = params[:stripeShippingAddressCountryCode]
    @shipping_address_zip_code = params[:stripeShippingAddressZip]
    @shipping_address = params[:stripeShippingAddressLine1]
    @shipping_state = params[:stripeShippingAddressCity]
    @shipping_city = params[:stripeShippingAddressState]
  end
end
