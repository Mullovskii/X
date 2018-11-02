require 'test_helper'

class ShippingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping = shippings(:one)
  end

  test "should get index" do
    get shippings_url, as: :json
    assert_response :success
  end

  test "should create shipping" do
    assert_difference('Shipping.count') do
      post shippings_url, params: { shipping: { note: @shipping.note, order_id_id: @shipping.order_id_id, provider: @shipping.provider, shop_id_id: @shipping.shop_id_id, status: @shipping.status, tracking_number: @shipping.tracking_number } }, as: :json
    end

    assert_response 201
  end

  test "should show shipping" do
    get shipping_url(@shipping), as: :json
    assert_response :success
  end

  test "should update shipping" do
    patch shipping_url(@shipping), params: { shipping: { note: @shipping.note, order_id_id: @shipping.order_id_id, provider: @shipping.provider, shop_id_id: @shipping.shop_id_id, status: @shipping.status, tracking_number: @shipping.tracking_number } }, as: :json
    assert_response 200
  end

  test "should destroy shipping" do
    assert_difference('Shipping.count', -1) do
      delete shipping_url(@shipping), as: :json
    end

    assert_response 204
  end
end
