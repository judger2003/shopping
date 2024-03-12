# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
god_user = User.create!(
  email: '809697142@qq.com',
  password: 'haqs12345',
  password_confirmation: 'haqs12345',
  phone_number: "13410555425",
  username: "judger2003"
)

god_user.add_role :god