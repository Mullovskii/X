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

Country.create(name: "United States", country_code: 1, country_iso: 'us', currency_id: 1)
Country.create(name: "France", country_code: 33, country_iso: 'fr', currency_id: 2)
Country.create(name: "Germany", country_code: 49, country_iso: 'de', currency_id: 2)
Country.create(name: "Italy", country_code: 39, country_iso: 'it', currency_id: 2)
Country.create(name: "Spain", country_code: 34, country_iso: 'sp', currency_id: 2)
Country.create(name: "United Kingdom", country_code: 44, country_iso: 'gb', currency_id: 3)
Country.create(name: "Russia", country_code: 7, country_iso: 'ru', currency_id: 4)
Country.create(name: "Republic of Korea", country_code: 82, country_iso: 'kr', currency_id: 5)
Country.create(name: "Japan", country_code: 81, country_iso: 'jp', currency_id: 6)


#first level category
#1
Category.create(name: "Apparel & Accessories", google_category_id: 166, level: 0)

#second level category
#2
Category.create(name: "Clothing", google_category_id: 1604, level: 1, parent_id: 1)
#3
Category.create(name: "Clothing Accessories", google_category_id: 167, level: 1, parent_id: 1)
#4
Category.create(name: "Handbags, Wallets & Cases", google_category_id: 6551, level: 1, parent_id: 1)
#5
Category.create(name: "Jewelry", google_category_id: 188, level: 1, parent_id: 1)
									

#third level category
#Clothing
#6
Category.create(name: "Activewear", google_category_id: 5322, level: 2, parent_id: 2)
#7
Category.create(name: "Baby & Toddler Clothing", google_category_id: 182, level: 2, parent_id: 2)
#8
Category.create(name: "Dresses", google_category_id: 182, level: 2, parent_id: 2)
#9
Category.create(name: "Pants", google_category_id: 204, level: 2, parent_id: 2)
#10
Category.create(name: "Outwear", google_category_id: 203, level: 2, parent_id: 2)
#11
Category.create(name: "Shirts & Tops", google_category_id: 212, level: 2, parent_id: 2)
#12
Category.create(name: "Shorts", google_category_id: 1581, level: 2, parent_id: 2)
#13
Category.create(name: "Skorts", google_category_id: 5344, level: 2, parent_id: 2)
#14
Category.create(name: "Sleepwear & Loungewear", google_category_id: 208, level: 2, parent_id: 2)
#15
Category.create(name: "Suits", google_category_id: 1594, level: 2, parent_id: 2)
#16
Category.create(name: "Swimwear", google_category_id: 211, level: 2, parent_id: 2)
#17
Category.create(name: "Underwear & Socks", google_category_id: 213, level: 2, parent_id: 2)
#18
Category.create(name: "Uniforms", google_category_id: 2306, level: 2, parent_id: 2)

#Clothing Accessories
#19
Category.create(name: "Arm Warmers & Sleeves", google_category_id: 5942, level: 2, parent_id: 3)
#20
Category.create(name: "Belts", google_category_id: 169, level: 2, parent_id: 3)
#21
Category.create(name: "Cufflinks", google_category_id: 193, level: 2, parent_id: 3)
#22
Category.create(name: "Gloves & Mittens", google_category_id: 170, level: 2, parent_id: 3)
#23
Category.create(name: "Hair Accessories", google_category_id: 171, level: 2, parent_id: 3)
#24
Category.create(name: "Headwear", google_category_id: 2020, level: 2, parent_id: 3)
#25
Category.create(name: "Scarves & Shawls", google_category_id: 177, level: 2, parent_id: 3)
#26
Category.create(name: "Sunglasses", google_category_id: 178, level: 2, parent_id: 3)


#Handbags, Wallets & Cases	
#27
Category.create(name: "Handbags", google_category_id: 3032, level: 2, parent_id: 4)
#28
Category.create(name: "Wallets & Money Clips", google_category_id: 2668, level: 2, parent_id: 4)
	

#Jewelry
#29
Category.create(name: "Anklets", google_category_id: 189, level: 2, parent_id: 5)
#30
Category.create(name: "Body Jewelry", google_category_id: 190, level: 2, parent_id: 5)
#31
Category.create(name: "Bracelets", google_category_id: 191, level: 2, parent_id: 5)
#32
Category.create(name: "Brooches & Lapel Pins", google_category_id: 197, level: 2, parent_id: 5)
#33
Category.create(name: "Charms & Pendants", google_category_id: 192, level: 2, parent_id: 5)

#34
Category.create(name: "Earrings", google_category_id: 194, level: 2, parent_id: 5)
#35
Category.create(name: "Necklaces", google_category_id: 196, level: 2, parent_id: 5)
#36
Category.create(name: "Rings", google_category_id: 200, level: 2, parent_id: 5)
#37
Category.create(name: "Body Jewelry", google_category_id: 190, level: 2, parent_id: 5)
#38
Category.create(name: "Watches", google_category_id: 201, level: 2, parent_id: 5)
#39
Category.create(name: "Shoes", google_category_id: 187, level: 2, parent_id: 5)


			
		




