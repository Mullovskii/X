require 'test_helper'

class DisputesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dispute = disputes(:one)
  end

  test "should get index" do
    get disputes_url, as: :json
    assert_response :success
  end

  test "should create dispute" do
    assert_difference('Dispute.count') do
      post disputes_url, params: { dispute: { address_id: @dispute.address_id, comment: @dispute.comment, order_id: @dispute.order_id, proof1: @dispute.proof1, proof2: @dispute.proof2, proof3: @dispute.proof3, proof4: @dispute.proof4, proof5: @dispute.proof5, reason: @dispute.reason, shipping_id: @dispute.shipping_id, shop_agreement: @dispute.shop_agreement, shop_id: @dispute.shop_id, status: @dispute.status, user_id: @dispute.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show dispute" do
    get dispute_url(@dispute), as: :json
    assert_response :success
  end

  test "should update dispute" do
    patch dispute_url(@dispute), params: { dispute: { address_id: @dispute.address_id, comment: @dispute.comment, order_id: @dispute.order_id, proof1: @dispute.proof1, proof2: @dispute.proof2, proof3: @dispute.proof3, proof4: @dispute.proof4, proof5: @dispute.proof5, reason: @dispute.reason, shipping_id: @dispute.shipping_id, shop_agreement: @dispute.shop_agreement, shop_id: @dispute.shop_id, status: @dispute.status, user_id: @dispute.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy dispute" do
    assert_difference('Dispute.count', -1) do
      delete dispute_url(@dispute), as: :json
    end

    assert_response 204
  end
end
