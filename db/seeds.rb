# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Message.destroy_all
Channel.destroy_all

users = User.create([
  {username: 'guest', password: '123456' },
  {username: 'Vincent Vega', password: '123456' },
  {username: 'Jules Winnfield', password: '123456' },
])

channels = Channel.create([
  {id: 1, name: 'general', description: 'default channel' },
  {name: 'Fox News', description: 'channel1' },
  {name: 'Comedy Central', description: 'channel2' },
  {name: 'Cartoon Network', description: 'channel3' },
])
