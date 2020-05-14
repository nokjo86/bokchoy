require_relative "data/users"

listings = [
    "Yummy Tomato for sale",
    "Green Bokchoy fresh from yard",
    "Best batch ever beets"
  ]

puts "All #{User.all.length} user record/s deleted"
User.destroy_all

i = 0
users.each do |user|
  seller = User.create(user)
  listing = seller.profile.listings.create(
    title: listings[i],
    description: Faker::Lorem.sentences(number: 3).join(" "),
    price: rand(1.01..5.00),
    delivery: rand(1..3)
  )
  listings[i] = listing
  i += 1
end

i = 0
listings.each do |listing|
  listing.picture.attach(
    io: File.open("app/assets/images/#{i}.jpg"),
    filename: "test#{i}.jpg",
    content_type: "image/jpg"
  )
  i += 0
end

puts listings
puts "#{User.all.length} user record/s created."

