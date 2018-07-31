require 'test_helper'

class CountryShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @country_shop = country_shops(:one)
  end

  test "should get index" do
    get country_shops_url, as: :json
    assert_response :success
  end

  test "should create country_shop" do
    assert_difference('CountryShop.count') do
      post country_shops_url, params: { country_shop: { country_id: @country_shop.country_id, mode: @country_shop.mode, shop_id: @country_shop.shop_id } }, as: :json
    end

    assert_response 201
  end

  test "should show country_shop" do
    get country_shop_url(@country_shop), as: :json
    assert_response :success
  end

  test "should update country_shop" do
    patch country_shop_url(@country_shop), params: { country_shop: { country_id: @country_shop.country_id, mode: @country_shop.mode, shop_id: @country_shop.shop_id } }, as: :json
    assert_response 200
  end

  test "should destroy country_shop" do
    assert_difference('CountryShop.count', -1) do
      delete country_shop_url(@country_shop), as: :json
    end

    assert_response 204
  end
end
