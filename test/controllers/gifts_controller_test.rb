require 'test_helper'

class GiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gift = gifts(:one)
  end

  test "should get index" do
    get gifts_url, as: :json
    assert_response :success
  end

  test "should create gift" do
    assert_difference('Gift.count') do
      post gifts_url, params: { gift: { campaign_id: @gift.campaign_id, delivery_details: @gift.delivery_details, description: @gift.description, expiration_date: @gift.expiration_date, image_link_0: @gift.image_link_0, image_link_1: @gift.image_link_1, image_link_2: @gift.image_link_2, image_link_3: @gift.image_link_3, image_link_4: @gift.image_link_4, main_image_link: @gift.main_image_link, name: @gift.name, number_of_units: @gift.number_of_units, product_id: @gift.product_id, shop_id: @gift.shop_id, status: @gift.status } }, as: :json
    end

    assert_response 201
  end

  test "should show gift" do
    get gift_url(@gift), as: :json
    assert_response :success
  end

  test "should update gift" do
    patch gift_url(@gift), params: { gift: { campaign_id: @gift.campaign_id, delivery_details: @gift.delivery_details, description: @gift.description, expiration_date: @gift.expiration_date, image_link_0: @gift.image_link_0, image_link_1: @gift.image_link_1, image_link_2: @gift.image_link_2, image_link_3: @gift.image_link_3, image_link_4: @gift.image_link_4, main_image_link: @gift.main_image_link, name: @gift.name, number_of_units: @gift.number_of_units, product_id: @gift.product_id, shop_id: @gift.shop_id, status: @gift.status } }, as: :json
    assert_response 200
  end

  test "should destroy gift" do
    assert_difference('Gift.count', -1) do
      delete gift_url(@gift), as: :json
    end

    assert_response 204
  end
end
