class PaymentsController < ApplicationController
  def get_stripe_id
    cartitems = current_user.profile.cart.cart_items
    list_of_items = []
    cartitems.each do |item|
      listing = Listing.find(item.listing_id)
      item_info = {
        name: listing.title,
        description: listing.description,
        amount: listing.price * 100,
        currency: 'aud',
        quantity: item.quantity
      }
      list_of_items << item_info
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
      success_url: "#{root_url}",
      cancel_url: "#{root_url}cart"
    ).id
    render :json => {id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key)}
  end
end
# payments/success?userId=#{current_user.id}&listingId=#{@listing.id}