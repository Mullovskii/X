require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url, as: :json
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { adult: @product.adult, age_group: @product.age_group, availability: @product.availability, availability_date: @product.availability_date, brand: @product.brand, brand_id: @product.brand_id, color: @product.color, condition: @product.condition, cost_of_goods_sold: @product.cost_of_goods_sold, custom_id: @product.custom_id, custom_label_0: @product.custom_label_0, custom_label_1: @product.custom_label_1, description: @product.description, energy_efficiency_class: @product.energy_efficiency_class, expiration_date: @product.expiration_date, gender: @product.gender, gtin: @product.gtin, identifier_exists: @product.identifier_exists, installment: @product.installment, is_bundle: @product.is_bundle, item_group_id: @product.item_group_id, link: @product.link, loyalty_points: @product.loyalty_points, main_category_id: @product.main_category_id, main_image_link: @product.main_image_link, material: @product.material, max_energy_efficiency_class: @product.max_energy_efficiency_class, max_handling_time: @product.max_handling_time, min_energy_efficiency_class: @product.min_energy_efficiency_class, min_handling_time: @product.min_handling_time, mpn: @product.mpn, multipack: @product.multipack, pattern: @product.pattern, price: @product.price, product_type: @product.product_type, sale_price: @product.sale_price, sale_price_effective_date: @product.sale_price_effective_date, shipping: @product.shipping, shipping_height: @product.shipping_height, shipping_label: @product.shipping_label, shipping_length: @product.shipping_length, shipping_weight: @product.shipping_weight, shipping_width: @product.shipping_width, size: @product.size, size_system: @product.size_system, tax: @product.tax, tax_category: @product.tax_category, title: @product.title, unit_pricing_base_measure: @product.unit_pricing_base_measure, unit_pricing_measure: @product.unit_pricing_measure } }, as: :json
    end

    assert_response 201
  end

  test "should show product" do
    get product_url(@product), as: :json
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { adult: @product.adult, age_group: @product.age_group, availability: @product.availability, availability_date: @product.availability_date, brand: @product.brand, brand_id: @product.brand_id, color: @product.color, condition: @product.condition, cost_of_goods_sold: @product.cost_of_goods_sold, custom_id: @product.custom_id, custom_label_0: @product.custom_label_0, custom_label_1: @product.custom_label_1, description: @product.description, energy_efficiency_class: @product.energy_efficiency_class, expiration_date: @product.expiration_date, gender: @product.gender, gtin: @product.gtin, identifier_exists: @product.identifier_exists, installment: @product.installment, is_bundle: @product.is_bundle, item_group_id: @product.item_group_id, link: @product.link, loyalty_points: @product.loyalty_points, main_category_id: @product.main_category_id, main_image_link: @product.main_image_link, material: @product.material, max_energy_efficiency_class: @product.max_energy_efficiency_class, max_handling_time: @product.max_handling_time, min_energy_efficiency_class: @product.min_energy_efficiency_class, min_handling_time: @product.min_handling_time, mpn: @product.mpn, multipack: @product.multipack, pattern: @product.pattern, price: @product.price, product_type: @product.product_type, sale_price: @product.sale_price, sale_price_effective_date: @product.sale_price_effective_date, shipping: @product.shipping, shipping_height: @product.shipping_height, shipping_label: @product.shipping_label, shipping_length: @product.shipping_length, shipping_weight: @product.shipping_weight, shipping_width: @product.shipping_width, size: @product.size, size_system: @product.size_system, tax: @product.tax, tax_category: @product.tax_category, title: @product.title, unit_pricing_base_measure: @product.unit_pricing_base_measure, unit_pricing_measure: @product.unit_pricing_measure } }, as: :json
    assert_response 200
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product), as: :json
    end

    assert_response 204
  end
end
