require 'test_helper'

class RewardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reward = rewards(:one)
  end

  test "should get index" do
    get rewards_url, as: :json
    assert_response :success
  end

  test "should create reward" do
    assert_difference('Reward.count') do
      post rewards_url, params: { reward: { bonus_exchange: @reward.bonus_exchange, bonus_max_time: @reward.bonus_max_time, bonus_min_time: @reward.bonus_min_time, country_id: @reward.country_id, currency_id: @reward.currency_id, delivery_mode: @reward.delivery_mode, fullfilment_mode: @reward.fullfilment_mode, gift_delivery_id: @reward.gift_delivery_id, gift_max_time: @reward.gift_max_time, gift_min_time: @reward.gift_min_time, gift_products: @reward.gift_products, no_card_instruction: @reward.no_card_instruction, other_instruction: @reward.other_instruction, point_to_bonus: @reward.point_to_bonus, point_to_lcy: @reward.point_to_lcy, point_to_usd: @reward.point_to_usd, prize_rewards: @reward.prize_rewards, product_reward: @reward.product_reward, shop_id: @reward.shop_id, surf_voucher_generation: @reward.surf_voucher_generation, voucher_instruction: @reward.voucher_instruction, voucher_use: @reward.voucher_use } }, as: :json
    end

    assert_response 201
  end

  test "should show reward" do
    get reward_url(@reward), as: :json
    assert_response :success
  end

  test "should update reward" do
    patch reward_url(@reward), params: { reward: { bonus_exchange: @reward.bonus_exchange, bonus_max_time: @reward.bonus_max_time, bonus_min_time: @reward.bonus_min_time, country_id: @reward.country_id, currency_id: @reward.currency_id, delivery_mode: @reward.delivery_mode, fullfilment_mode: @reward.fullfilment_mode, gift_delivery_id: @reward.gift_delivery_id, gift_max_time: @reward.gift_max_time, gift_min_time: @reward.gift_min_time, gift_products: @reward.gift_products, no_card_instruction: @reward.no_card_instruction, other_instruction: @reward.other_instruction, point_to_bonus: @reward.point_to_bonus, point_to_lcy: @reward.point_to_lcy, point_to_usd: @reward.point_to_usd, prize_rewards: @reward.prize_rewards, product_reward: @reward.product_reward, shop_id: @reward.shop_id, surf_voucher_generation: @reward.surf_voucher_generation, voucher_instruction: @reward.voucher_instruction, voucher_use: @reward.voucher_use } }, as: :json
    assert_response 200
  end

  test "should destroy reward" do
    assert_difference('Reward.count', -1) do
      delete reward_url(@reward), as: :json
    end

    assert_response 204
  end
end
