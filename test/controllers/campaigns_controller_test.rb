require 'test_helper'

class CampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign = campaigns(:one)
  end

  test "should get index" do
    get campaigns_url, as: :json
    assert_response :success
  end

  test "should create campaign" do
    assert_difference('Campaign.count') do
      post campaigns_url, params: { campaign: { actions_per_gift: @campaign.actions_per_gift, bid_per_action: @campaign.bid_per_action, currency_id: @campaign.currency_id, followers_threshold: @campaign.followers_threshold, gift_id: @campaign.gift_id, kind: @campaign.kind, mode: @campaign.mode, name: @campaign.name, shop_id: @campaign.shop_id, status: @campaign.status } }, as: :json
    end

    assert_response 201
  end

  test "should show campaign" do
    get campaign_url(@campaign), as: :json
    assert_response :success
  end

  test "should update campaign" do
    patch campaign_url(@campaign), params: { campaign: { actions_per_gift: @campaign.actions_per_gift, bid_per_action: @campaign.bid_per_action, currency_id: @campaign.currency_id, followers_threshold: @campaign.followers_threshold, gift_id: @campaign.gift_id, kind: @campaign.kind, mode: @campaign.mode, name: @campaign.name, shop_id: @campaign.shop_id, status: @campaign.status } }, as: :json
    assert_response 200
  end

  test "should destroy campaign" do
    assert_difference('Campaign.count', -1) do
      delete campaign_url(@campaign), as: :json
    end

    assert_response 204
  end
end
