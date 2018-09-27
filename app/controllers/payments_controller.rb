# frozen_string_literal: true

# payment controller
class PaymentsController < ApplicationController
  def new
    @amount = Payment.total_amount(current_user.id)
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
      Payment.update_order_status(current_user.id, @amount/100)
    end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end
