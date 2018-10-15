# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Country.create(name: "United States")
Currency.create(name: "USD", country_id: 1)
Country.create(name: "Russia")
Currency.create(name: "RUB", country_id: 2, usd_rate: 65.51)