require 'test_helper'

class ProductCouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_coupon = product_coupons(:one)
  end

  test "should get index" do
    get product_coupons_url, as: :json
    assert_response :success
  end

  test "should create product_coupon" do
    assert_difference('ProductCoupon.count') do
      post product_coupons_url, params: { product_coupon: { coupon_id: @product_coupon.coupon_id, product_id: @product_coupon.product_id } }, as: :json
    end

    assert_response 201
  end

  test "should show product_coupon" do
    get product_coupon_url(@product_coupon), as: :json
    assert_response :success
  end

  test "should update product_coupon" do
    patch product_coupon_url(@product_coupon), params: { product_coupon: { coupon_id: @product_coupon.coupon_id, product_id: @product_coupon.product_id } }, as: :json
    assert_response 200
  end

  test "should destroy product_coupon" do
    assert_difference('ProductCoupon.count', -1) do
      delete product_coupon_url(@product_coupon), as: :json
    end

    assert_response 204
  end
end
