# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


admin = User.create({ email: 'admin@app.com', password: 'password', admin: true })
user = User.create({ email: 'user@app.com', password: 'password' })
# to add
# Location.create({ name: 'Easter Island', latitude: -27.112722, longitude: -109.349686, user_id: admin.id })
# Location.create({ name: 'Christmas Island', latitude: -10.447525, longitude: 105.690453, user_id: user.id })
