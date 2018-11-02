require 'test_helper'

class ShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = shops(:one)
  end

  test "should get index" do
    get shops_url, as: :json
    assert_response :success
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      post shops_url, params: { shop: { avatar: @shop.avatar, background: @shop.background, business_type: @shop.business_type, integration_type: @shop.integration_type, legal_name: @shop.legal_name, main_category_id: @shop.main_category_id, main_country_id: @shop.main_country_id, mana: @shop.mana, name: @shop.name, payment_rules: @shop.payment_rules, phone: @shop.phone, registration_number: @shop.registration_number, status: @shop.status, user_id: @shop.user_id, website: @shop.website } }, as: :json
    end

    assert_response 201
  end

  test "should show shop" do
    get shop_url(@shop), as: :json
    assert_response :success
  end

  test "should update shop" do
    patch shop_url(@shop), params: { shop: { avatar: @shop.avatar, background: @shop.background, business_type: @shop.business_type, integration_type: @shop.integration_type, legal_name: @shop.legal_name, main_category_id: @shop.main_category_id, main_country_id: @shop.main_country_id, mana: @shop.mana, name: @shop.name, payment_rules: @shop.payment_rules, phone: @shop.phone, registration_number: @shop.registration_number, status: @shop.status, user_id: @shop.user_id, website: @shop.website } }, as: :json
    assert_response 200
  end

  test "should destroy shop" do
    assert_difference('Shop.count', -1) do
      delete shop_url(@shop), as: :json
    end

    assert_response 204
  end
end
