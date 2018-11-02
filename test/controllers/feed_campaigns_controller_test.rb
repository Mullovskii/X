require 'test_helper'

class FeedCampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feed_campaign = feed_campaigns(:one)
  end

  test "should get index" do
    get feed_campaigns_url, as: :json
    assert_response :success
  end

  test "should create feed_campaign" do
    assert_difference('FeedCampaign.count') do
      post feed_campaigns_url, params: { feed_campaign: { campaign_id: @feed_campaign.campaign_id, feed_id: @feed_campaign.feed_id, status: @feed_campaign.status } }, as: :json
    end

    assert_response 201
  end

  test "should show feed_campaign" do
    get feed_campaign_url(@feed_campaign), as: :json
    assert_response :success
  end

  test "should update feed_campaign" do
    patch feed_campaign_url(@feed_campaign), params: { feed_campaign: { campaign_id: @feed_campaign.campaign_id, feed_id: @feed_campaign.feed_id, status: @feed_campaign.status } }, as: :json
    assert_response 200
  end

  test "should destroy feed_campaign" do
    assert_difference('FeedCampaign.count', -1) do
      delete feed_campaign_url(@feed_campaign), as: :json
    end

    assert_response 204
  end
end
