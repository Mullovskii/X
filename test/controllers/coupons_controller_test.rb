require 'test_helper'

class CouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get coupons_url, as: :json
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post coupons_url, params: { coupon: { additional_info: @coupon.additional_info, background: @coupon.background, buyer_id: @coupon.buyer_id, coupon_use: @coupon.coupon_use, discount: @coupon.discount, discount_mode: @coupon.discount_mode, discount_products: @coupon.discount_products, generated_amount: @coupon.generated_amount, generated_number: @coupon.generated_number, instruction: @coupon.instruction, kind: @coupon.kind, parent_id: @coupon.parent_id, point_price: @coupon.point_price, purchased_at: @coupon.purchased_at, secret_key: @coupon.secret_key, shop_id: @coupon.shop_id, status: @coupon.status, utilized_at: @coupon.utilized_at } }, as: :json
    end

    assert_response 201
  end

  test "should show coupon" do
    get coupon_url(@coupon), as: :json
    assert_response :success
  end

  test "should update coupon" do
    patch coupon_url(@coupon), params: { coupon: { additional_info: @coupon.additional_info, background: @coupon.background, buyer_id: @coupon.buyer_id, coupon_use: @coupon.coupon_use, discount: @coupon.discount, discount_mode: @coupon.discount_mode, discount_products: @coupon.discount_products, generated_amount: @coupon.generated_amount, generated_number: @coupon.generated_number, instruction: @coupon.instruction, kind: @coupon.kind, parent_id: @coupon.parent_id, point_price: @coupon.point_price, purchased_at: @coupon.purchased_at, secret_key: @coupon.secret_key, shop_id: @coupon.shop_id, status: @coupon.status, utilized_at: @coupon.utilized_at } }, as: :json
    assert_response 200
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete coupon_url(@coupon), as: :json
    end

    assert_response 204
  end
end
