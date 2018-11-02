require 'test_helper'

class SampleRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sample_request = sample_requests(:one)
  end

  test "should get index" do
    get sample_requests_url, as: :json
    assert_response :success
  end

  test "should create sample_request" do
    assert_difference('SampleRequest.count') do
      post sample_requests_url, params: { sample_request: { Product_id: @sample_request.Product_id, Shop_id: @sample_request.Shop_id, User_id: @sample_request.User_id, status: @sample_request.status } }, as: :json
    end

    assert_response 201
  end

  test "should show sample_request" do
    get sample_request_url(@sample_request), as: :json
    assert_response :success
  end

  test "should update sample_request" do
    patch sample_request_url(@sample_request), params: { sample_request: { Product_id: @sample_request.Product_id, Shop_id: @sample_request.Shop_id, User_id: @sample_request.User_id, status: @sample_request.status } }, as: :json
    assert_response 200
  end

  test "should destroy sample_request" do
    assert_difference('SampleRequest.count', -1) do
      delete sample_request_url(@sample_request), as: :json
    end

    assert_response 204
  end
end
