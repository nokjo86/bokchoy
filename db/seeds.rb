require_relative "data/users"
require_relative "data/user_details"

products = [
  "Vegetables",
  "Herbs",
  "Fruits",
  "Eggs",
  "Honey",
  "Mushrooms"
]

listings = [
    "Tomato",
    "Basil",
    "Orange",
    "Chicken eggs",
    "Honeycomb",
    "Basil",
    "Mushrooms"
  ]

puts "All #{User.all.length} user record/s deleted"
User.destroy_all

## Create product type list
products.each do |product|
  Product.create(
    name: product
  )
end

## Create users and auto create blank profiles
users.each do |user|
  seller = User.create(user)
end

## Update profiles
profiles = Profile.all
i = 0
profiles.each do |profile|
  profile.update(user_details[i])
  i += 1
end

sellers = Profile.joins(:user).where(users: { admin: false})

sellers.each do |seller|
  (1..6).each do |i|
    seller.listings.create(
      title: listings[i-1] + " " + seller.id.to_s,
      description: Faker::Lorem.sentences(number: 4).join(" "),
      price: rand(0.01..5.00).round(2),
      delivery: rand(1..3),
      product_id: i
    )
  end
  i = 0
  seller.listings.each do |listing|
    listing.image.attach(
    io: File.open("app/assets/images/p#{i}.jpeg"),
    filename: "p#{i}.jpeg",
    content_type: "image/jpg"
    )
    i += 1
  end
end


puts listings
puts "#{User.all.length} user record/s created."

