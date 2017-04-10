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
Track.create!(
  name: "This Charming Man - 2011 Remastered Version",
  artist: "The Smiths",
  album: "The Smiths",
  image_url: "https://i.scdn.co/image/f2b54f97eef229fe4757a008c5caa2aff1496530",
  spotify_id: "1FvDJ9KGxcqwv1utyPL3JZ"
)
Track.create!(
  name: "There Is A Light That Never Goes Out - 2011 Remastered Version",
  artist: "The Smiths",
  album: "The Queen Is Dead",
  image_url: "https://i.scdn.co/image/df20f7f7b4c8bf3e11fb043125a9b94d6a61967b",
  spotify_id: "0WQiDwKJclirSYG9v5tayI"
)
Track.create!(
  name: "Please, Please, Please Let Me Get What I Want - 2011 Remastered Version",
  artist: "The Smiths",
  album: "Hatful of Hollow",
  image_url: "https://i.scdn.co/image/3c17736bf01eb170161e3a5bee168df3588c001f",
  spotify_id: "6BrMEbPSSj55nQhkgf6DnE"
)

# for searchkick gem
Track.reindex
