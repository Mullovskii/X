require 'test_helper'

class ProductShowroomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_showroom = product_showrooms(:one)
  end

  test "should get index" do
    get product_showrooms_url, as: :json
    assert_response :success
  end

  test "should create product_showroom" do
    assert_difference('ProductShowroom.count') do
      post product_showrooms_url, params: { product_showroom: { product_id: @product_showroom.product_id, showroom_id: @product_showroom.showroom_id, status: @product_showroom.status } }, as: :json
    end

    assert_response 201
  end

  test "should show product_showroom" do
    get product_showroom_url(@product_showroom), as: :json
    assert_response :success
  end

  test "should update product_showroom" do
    patch product_showroom_url(@product_showroom), params: { product_showroom: { product_id: @product_showroom.product_id, showroom_id: @product_showroom.showroom_id, status: @product_showroom.status } }, as: :json
    assert_response 200
  end

  test "should destroy product_showroom" do
    assert_difference('ProductShowroom.count', -1) do
      delete product_showroom_url(@product_showroom), as: :json
    end

    assert_response 204
  end
end
