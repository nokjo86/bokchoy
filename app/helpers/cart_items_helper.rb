module CartItemsHelper
  def relationship(item)
    CartItem.find_by(listing_id: item.id)
  end
end
