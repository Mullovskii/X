require 'test_helper'

class StreetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @street = streets(:one)
  end

  test "should get index" do
    get streets_url, as: :json
    assert_response :success
  end

  test "should create street" do
    assert_difference('Street.count') do
      post streets_url, params: { street: { name: @street.name, references: @street.references } }, as: :json
    end

    assert_response 201
  end

  test "should show street" do
    get street_url(@street), as: :json
    assert_response :success
  end

  test "should update street" do
    patch street_url(@street), params: { street: { name: @street.name, references: @street.references } }, as: :json
    assert_response 200
  end

  test "should destroy street" do
    assert_difference('Street.count', -1) do
      delete street_url(@street), as: :json
    end

    assert_response 204
  end
end
