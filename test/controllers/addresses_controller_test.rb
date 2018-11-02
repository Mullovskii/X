require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:one)
  end

  test "should get index" do
    get addresses_url, as: :json
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post addresses_url, params: { address: { additional: @address.additional, city_id: @address.city_id, country_id: @address.country_id, owner_id: @address.owner_id, owner_type: @address.owner_type, postcode: @address.postcode, street_id: @address.street_id } }, as: :json
    end

    assert_response 201
  end

  test "should show address" do
    get address_url(@address), as: :json
    assert_response :success
  end

  test "should update address" do
    patch address_url(@address), params: { address: { additional: @address.additional, city_id: @address.city_id, country_id: @address.country_id, owner_id: @address.owner_id, owner_type: @address.owner_type, postcode: @address.postcode, street_id: @address.street_id } }, as: :json
    assert_response 200
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete address_url(@address), as: :json
    end

    assert_response 204
  end
end
