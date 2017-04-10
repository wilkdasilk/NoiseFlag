# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Flag.delete_all
User.delete_all
Track.delete_all

auston = User.create!(
    name: "Auston",
    current_city: "SF",
    email: "auston@me.com",
    password: "yeahyeah",
    password_confirmation: "yeahyeah",
    latitude: 37.790882,
    longitude: -122.401552
)
superman = User.create!(
    name: "Superman",
    current_city: "New York",
    email: "superman@me.com",
    password: "nonono",
    password_confirmation: "nonono",
    latitude: 40.748541,
    longitude: -73.985758
)
batman = User.create!(
    name: "Batman",
    current_city: "NYC",
    email: "batman@me.com",
    password: "iambatman",
    password_confirmation: "iambatman",
    latitude: 40.706086,
    longitude: -73.996864
)
auston.flags.create!(
  name: "GA Radness",
  description: "Only the most radical tunes. Gimme your 90s!",
  latitude: 37.790882,
  longitude: -122.401552
)
batman.flags.create!(
    name: "Magic",
    description: "This is where it happens! All that glitters is gold. Smash Mouth tunes welcome",
    latitude: 40.706086,
    longitude: -73.996864
)
superman.flags.create!(
  name: "Sammy's Spot",
  description: "Everything awesome welcome. Unless I don't like it",
  latitude: 40.748541,
  longitude: -73.985758
)

# for searchkick gem
Track.reindex
