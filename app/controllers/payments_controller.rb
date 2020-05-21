class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
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
          user_id: current_user.id,
          delivery: params[:delivery],
          total: total
        }
      },
      success_url: "#{root_url}payments/success?method=#{params[:delivery]}&amount=#{total}",
      cancel_url: "#{root_url}cart"
    ).id
    render :json => { id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key) }
  end

  def webhook
    if params[:type] == "checkout.session.completed"
      payment_id = params[:data][:object][:payment_intent]
      payment = Stripe::PaymentIntent.retrieve(payment_id)
      user_id = payment.metadata.user_id

      user = User.find(user_id)
      order = user.profile.orders.create(
        delivery: payment.metadata.delivery.to_i,
        total_amount_paid: payment.metadata.total.to_f.round(2)
      )
      cart_items = user.profile.cart.cart_items
      cart_items.each do |item|
        OrderItem.create(
          order_id: order.id,
          listing_id: item.listing_id,
          quantity: item.quantity
        )
        Message.create(
          listing_id: item.listing_id,
          sender_id: user.profile.id,
          recipient_id: Listing.find(item.listing_id).profile_id,
          body: "<System generated> Payment has been made for #{item.quantity} unit/s"
        )
      end
      user.profile.cart.listings.delete_all
    end
    head 200
  end

  def success
    flash[:success] = "Payment completed. You can view your order from order history. Please contact the seller to organise delivery/pickup."
    redirect_to listings_path
  end
end
