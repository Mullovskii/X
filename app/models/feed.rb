class Feed < ApplicationRecord
	include ActionView::Helpers::SanitizeHelper

	belongs_to :shop
	belongs_to :country
	belongs_to :delivery
	belongs_to :currency
	has_many :products, dependent: :destroy
	# has_many :gifts, dependent: :destroy
	has_many :feed_campaigns
	has_many :campaigns, through: :feed_campaigns
	enum mode: [:file, :mannual]
	enum format: [:xlsx, :csv, :txt]
	enum kind: [:product_feed, :gift_feed]
	mount_uploader :file, FeedUploader


	# after_update :products_gift_mode

	# def products_gift_mode
	# 	if self.saved_change_to_gift_mode?
	# 		if self.gift_mode == true
	# 			self.products.each do |product|
	# 				product.gift_mode = true
	# 				if self.shop.reward && self.shop.reward.product_reward == true
	# 					if self.shop.reward.currency_id == self.currency_id
	# 						product.point_price = (product.price / self.shop.reward.point_to_lcy*100).round / 100.0
	# 					else
	# 						product.point_price = (product.price / self.currency.usd_rate / self.shop.reward.point_to_usd*100).round / 100.0
	# 					end	
	# 				end
	# 				product.save
	# 			end
	# 		else
	# 			self.products.each do |product|
	# 				product.gift_mode = false
	# 				product.save
	# 			end
	# 		end
	# 	end
	# end

	def load_products
		file = File.join(Rails.root, 'app', 'files', "Shopify.csv")
		if file.match(".csv")
			require "csv"
	        CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
	        	puts row.headers

	        	if row.to_h[:id]
	        	#surf .csv import file
		        	if row.to_h[:id] && row.to_h[:id].length <= 50 && self.shop.products.where(custom_id: row.to_h[:id]).take
		        		product = self.shop.products.where(custom_id: row.to_h[:id]).take
		        	else 
			        	if row.to_h[:id] && row.to_h[:id].length <= 50
			        		product = Product.create(feed_id: self.id, shop_id: self.shop_id, country_id: self.country_id)
			        		product.custom_id = row.to_h[:id]
			        	end
		        	end
		        	if row.to_h[:title] && row.to_h[:title].length <= 100
		        		product.title = row.to_h[:title]
		        	end

		        	if row.to_h[:description] && row.to_h[:description].length <= 1000
		        		product.description = row.to_h[:description]
		        	end

		        	if row.to_h[:brand] && row.to_h[:brand].length <= 50
		        		product.brand_name = row.to_h[:brand]
		        		if Brand.where(name: product.brand_name).take
		        			product.brand_id = Brand.where(name: product.brand_name).take.id
		        		else 
		        			brand = Brand.create(name: product.brand_name)
		        			product.brand_id = brand.id
		        		end
		        	end

		        	if row.to_h[:type] && row.to_h[:type].length <= 100
		        		product.product_type = row.to_h[:type]
		        		if Category.where(name: product.product_type).take 
		        			product.main_category_id = Category.where(name: product.product_type).take.id
		        		elsif Category.where(google_category_id: product.product_type.to_i).take
		        			product.main_category_id = Category.where(google_category_id: product.product_type.to_i).take
		        		end
		        	end

		        	if row.to_h[:link] && row.to_h[:link].length <= 300 

		        		if /https?:\/\/[\S]+/.match(row.to_h[:link]) 
		        			product.link = row.to_h[:link]	
		        		end
		        	end

		        	if row.to_h[:image_link_0] && row.to_h[:image_link_0].length <= 300 
		        		if /https?:\/\/[\S]+/.match(row.to_h[:image_link_0]) 
		        			product.image_link_0 = row.to_h[:image_link_0]
		        		end
		        	end

		        	if row.to_h[:image_link_1] && row.to_h[:image_link_1].length <= 300 
		        		if /https?:\/\/[\S]+/.match(row.to_h[:image_link_1]) 
		        			product.image_link_1 = row.to_h[:image_link_1]
		        		end
		        	end

		        	if row.to_h[:image_link_2] && row.to_h[:image_link_2].length <= 300 
		        		if /https?:\/\/[\S]+/.match(row.to_h[:image_link_2]) 
		        			product.image_link_2 = row.to_h[:image_link_2]
		        		end
		        	end

		        	if row.to_h[:image_link_3] && row.to_h[:image_link_3].length <= 300 
		        		if /https?:\/\/[\S]+/.match(row.to_h[:image_link_3]) 
		        			product.image_link_3 = row.to_h[:image_link_3]
		        		end
		        	end

		        	if row.to_h[:image_link_4] && row.to_h[:image_link_4].length <= 300 
		        		if /https?:\/\/[\S]+/.match(row.to_h[:image_link_4]) 
		        			product.image_link_4 = row.to_h[:image_link_4]
		        		end
		        	end
		          	
		          	if row.to_h[:availability]
			        	if row.to_h[:availability].downcase == "in stock" || row.to_h[:availability].downcase == "out of stock" || ow.to_h[:availability] == "preorder" 
			        		product.availability = row.to_h[:availability]
			        	end
			        end

		          	if row.to_h[:availability_date] &&   #добавить проверку на формат даты
		        		product.availability_date = Date.strptime(row.to_h[:availability_date]) rescue true
		        	end

		        	if row.to_h[:expiration_date] 
		        		product.expiration_date = Date.strptime(row.to_h[:expiration_date]) rescue true
		        	end

		        	if row.to_h[:price]
		        		# Currency.all.map{|c|c.name}
		    #     		currencies = %w(USD RUB EUR TRY $ £)
						# currencies_pattern = currencies.map {|c| Regexp.escape(c) }.join("|")
						# full_pattern = /(?<!\w)\d*\s*(#{currencies_pattern})\s*\d*(?!\w)/i
						if float_number = /(\d+[,.]\d+)/.match(row.to_h[:price])[1]
							product.price = float_number.to_f
						elsif integer = row.to_h[:price].scan(/\d+|[A-Za-z]+/)[0]
							product.price = integer.to_f
						end      		
		        	end

		        	if row.to_h[:sale_price] 
		        		# Currency.all.map{|c|c.name}
		        		if float_number = /(\d+[,.]\d+)/.match(row.to_h[:sale_price])[1] rescue false
							product.sale_price = float_number.to_f
						elsif integer = row.to_h[:sale_price].scan(/\d+|[A-Za-z]+/)[0] rescue false
							product.sale_price = integer.to_f
						end 
		        	end
		          	      
		          	if row.to_h[:sale_price_effective_date] 
		        		product.sale_price_effective_date = Date.strptime(row.to_h[:sale_price_effective_date]) rescue true
		        	end    	
		          	
		          	# if row.to_h[:gift_mode]
		          	# 	if row.to_h[:gift_mode].downcase == "true" || row.to_h[:gift_mode].downcase == "false"
		          	# 		product.gift_mode = row.to_h[:gift_mode]
		          	# 	end
		          	# end
		          	
		          	
		          	# if row.to_h[:point_price].to_f
		          	# 	product.point_price = row.to_h[:point_price]
		          	# end
		          	

		          	if row.to_h[:sample_mode]
		          		if row.to_h[:sample_mode].downcase == "true" || row.to_h[:sample_mode].downcase == "false"
		          			product.sample_mode = row.to_h[:sample_mode]
		          		end
		          	end
		          	
		          	if row.to_h[:campaign_label] && row.to_h[:campaign_label].length <= 50
		        		product.campaign_label = row.to_h[:campaign_label]
		        	end

		        	if row.to_h[:color] && row.to_h[:color].length <= 50
		        		product.color = row.to_h[:color]
		        	end

		        	if row.to_h[:gender]
			        	if row.to_h[:gender].downcase == "male" || row.to_h[:gender].downcase == "female" || row.to_h[:gender] == "unisex"
			        		product.gender = row.to_h[:gender]
			        	end
			        end
		          	
		          	if row.to_h[:material] && row.to_h[:material].length <= 50
		        		product.material = row.to_h[:material]
		        	end

		        	if row.to_h[:pattern] && row.to_h[:pattern].length <= 100
		        		product.pattern = row.to_h[:pattern]
		        	end

		        	if row.to_h[:size] && row.to_h[:size].length <= 100
		        		product.size = row.to_h[:size]
		        	end

		        	if row.to_h[:size_system] && ("US, UK, EU, DE, FR, JP, CN (China), IT, BR, MEX, AU, RU").match(row.to_h[:size_system])
		        		product.size_system = row.to_h[:size_system]
		        	end

		        	if row.to_h[:shipping_label] && row.to_h[:size].length <= 100
		        		product.shipping_label = row.to_h[:shipping_label]
		        		#можно потом добавить привязку delivery_id
		        	end
		          	
		          	if row.to_h[:tax] #добавить проверку 
		        		product.tax = row.to_h[:tax]
		        	end
		          

		          	if row.to_h[:adult]
		          		if row.to_h[:adult].downcase == "true" || row.to_h[:adult].downcase == "false"
		          			product.adult = row.to_h[:adult]
		          		end
		          	end
		          	
		          	product.save!

	        	elsif row.to_h[:handle]
	        	#shopify .csv import file
	        		
	        		if row.to_h[:handle] && row.to_h[:handle].length <= 500 && self.shop.products.where(custom_id: row.to_h[:handle]).take
		        		product = self.shop.products.where(custom_id: row.to_h[:handle]).take
		        	else 
			        	if row.to_h[:handle] && row.to_h[:handle].length <= 500
			        		product = Product.create(feed_id: self.id, shop_id: self.shop_id, country_id: self.country_id)
			        		product.custom_id = row.to_h[:handle]
			        		product.link = self.shop.website+"products/"+product.custom_id
			        	end
		        	end
		        	if row.to_h[:title] && row.to_h[:title].length <= 500
		        		product.title = row.to_h[:title]
		        	end
		        	if row.to_h[:body_html] && row.to_h[:body_html].length <= 10000
		        		text = strip_tags(row.to_h[:body_html])
		        		product.description = text
		        	end
		        	if row.to_h[:vendor] && row.to_h[:vendor].length <= 500
		        		product.brand_name = row.to_h[:vendor]
		        		if Brand.where(name: product.brand_name).take
		        			product.brand_id = Brand.where(name: product.brand_name).take.id
		        		else 
		        			brand = Brand.create(name: product.brand_name)
		        			product.brand_id = brand.id
		        		end
		        	end
		        	if row.to_h[:type] && row.to_h[:type].length <= 1000
		        		product.product_type = row.to_h[:type]
		        		Category.all.each do |category|
		        			if (category.name).match(product.product_type)
		        				product.main_category_id = category.id
		        			end
		        		end
		        	end
		        	if row.to_h[:tags]
		        		row.to_h[:tags].split.each do |tag|
		        			hashtag = Hashtag.create(name: tag)
		        			Tag.create(tagged_id: product.id, tagged_type: "Product", tagger_id: hashtag.id, tagger_type: "Hashtag")
		        		end
		        	end
		        	if row.to_h[:published]
			        	if row.to_h[:published].downcase == "true" || row.to_h[:published].downcase == "false" 
			        		product.availability = row.to_h[:published]
			        	end
			        end
			        if row.to_h[:variant_price]
						if float_number = /(\d+[,.]\d+)/.match(row.to_h[:variant_price])[1] rescue false
							product.price = float_number
						elsif integer = row.to_h[:variant_price].scan(/\d+|[A-Za-z]+/)[0] rescue false
							product.price = integer
						end
		        	end
		        	if row.to_h[:image_src] && row.to_h[:image_src].length <= 500 
		        		if /https?:\/\/[\S]+/.match(row.to_h[:image_src]) 
		        			product.image_link_0 = row.to_h[:image_src]
		        		end
		        	end
		        	if row.to_h[:variant_image] && row.to_h[:variant_image].length <= 10000 
		        		urls = row.to_h[:variant_image].split
	        			if /https?:\/\/[\S]+/.match(urls[0]) 
	        				product.image_link_1 = urls[0]
	        			end
	        			if /https?:\/\/[\S]+/.match(urls[1]) 
	        				product.image_link_2 = urls[1]
	        			end
	        			if /https?:\/\/[\S]+/.match(urls[2]) 
	        				product.image_link_3 = urls[2]
	        			end
	        			if /https?:\/\/[\S]+/.match(urls[3]) 
	        				product.image_link_4 = urls[3]
	        			end
		        	end
		        	if row.to_h[:google_shopping__google_product_category] && row.to_h[:google_shopping__google_product_category].length <= 100
		        		if Category.where(name: row.to_h[:google_shopping__google_product_category]).take 
		        			product.main_category_id = Category.where(name: row.to_h[:google_shopping__google_product_category]).take.id
		        		end
		        	end

		        	if row.to_h[:google_shopping__gender]
			        	if row.to_h[:google_shopping__gender].downcase == "male" || row.to_h[:google_shopping__gender].downcase == "female" || row.to_h[:google_shopping__gender].downcase == "unisex"
			        		product.gender = row.to_h[:google_shopping__gender]
			        	end
			        end
			        # if row.to_h[:variant_barcode] && row.to_h[:variant_barcode].length <= 500 
		        	# 	product.barcode = row.to_h[:variant_barcode]
		        	# end

		        	if row.to_h[:variant_tax_code] #добавить проверку 
		        		product.tax = row.to_h[:variant_tax_code]
		        	end

			        product.save!
	        	end

	        end	
		end
     
	end



end

