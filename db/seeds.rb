# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Flag.delete_all
User.delete_all

auston = User.create!(
    name: "Auston",
    current_city: "SF",
    email: "auston@me.com",
    password: "yeahyeah",
    password_confirmation: "yeahyeah"
)
superman = User.create!(
    name: "Superman",
    current_city: "New York",
    email: "superman@me.com",
    password: "nonono",
    password_confirmation: "nonono"
)
batman = User.create!(
    name: "Batman",
    current_city: "NYC",
    email: "batman@me.com",
    password: "iambatman",
    password_confirmation: "iambatman"
)
batman.flags.create!(
    name: "Magic",
    description: "This is where it happens! All that glitters is gold. Smash Mouth tunes welcome",
)
superman.flags.create!(
  name: "Sammy's Spot",
  description: "Everything awesome welcome. Unless I don't like it",
)
