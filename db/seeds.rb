# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Currency.create(name: "USD")
Currency.create(name: "EUR")
Currency.create(name: "GBP")
Currency.create(name: "RUB")
Currency.create(name: "KRW")
Currency.create(name: "JPY")

Country.create(name: "United States", currency_id: 1)
Country.create(name: "France", currency_id: 2)
Country.create(name: "Germany", currency_id: 2)
Country.create(name: "Italy", currency_id: 2)
Country.create(name: "Spain", currency_id: 2)
Country.create(name: "Great Britain", currency_id: 3)
Country.create(name: "Russia", currency_id: 4)
Country.create(name: "Republic of Korea", currency_id: 5)
Country.create(name: "Japan", currency_id: 6)
