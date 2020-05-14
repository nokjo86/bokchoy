class PaymentsController < ApplicationController
  def get_stripe_id
    cart_items = current_user.profile.cart.cart_items
    list_of_items = []
    total = 0
    cart_items.each do |item|
      listing = Listing.find(item.listing_id)
      item_info = {
        name: listing.title,
        description: listing.description,
        amount: (listing.price * 100).to_i,
        currency: 'aud',
        quantity: item.quantity
      }
      list_of_items << item_info
      total += listing.price * item.quantity
    end

    session_id = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: list_of_items,
      payment_intent_data: {
        metadata: {
          user_id: current_user.id
        }
      },
      success_url: "#{root_url}payments/success?method=#{params[:delivery]}&amount=#{total}",
      cancel_url: "#{root_url}cart"
    ).id
    render :json => {id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key)}
  end

  def success
    order = current_user.profile.orders.create(
      delivery: params[:method].to_i,
      total_amount_paid: params[:amount]
    )
    cart_items = current_user.profile.cart.cart_items
    cart_items.each do |item|
      OrderItem.create(
        order_id: order.id,
        listing_id: item.listing_id,
        quantity: item.quantity
      )
    end
    current_user.profile.cart.listings.delete_all
  end
end
