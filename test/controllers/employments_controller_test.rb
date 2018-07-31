require 'test_helper'

class EmploymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employment = employments(:one)
  end

  test "should get index" do
    get employments_url, as: :json
    assert_response :success
  end

  test "should create employment" do
    assert_difference('Employment.count') do
      post employments_url, params: { employment: { comment: @employment.comment, role: @employment.role, shop_id: @employment.shop_id, status: @employment.status, user_id: @employment.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show employment" do
    get employment_url(@employment), as: :json
    assert_response :success
  end

  test "should update employment" do
    patch employment_url(@employment), params: { employment: { comment: @employment.comment, role: @employment.role, shop_id: @employment.shop_id, status: @employment.status, user_id: @employment.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy employment" do
    assert_difference('Employment.count', -1) do
      delete employment_url(@employment), as: :json
    end

    assert_response 204
  end
end
