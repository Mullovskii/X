require 'test_helper'

class TariffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tariff = tariffs(:one)
  end

  test "should get index" do
    get tariffs_url, as: :json
    assert_response :success
  end

  test "should create tariff" do
    assert_difference('Tariff.count') do
      post tariffs_url, params: { tariff: { currency_id: @tariff.currency_id, days: @tariff.days, delivery_id: @tariff.delivery_id, mode: @tariff.mode, price: @tariff.price, price_from: @tariff.price_from, price_to: @tariff.price_to, weight_from: @tariff.weight_from, weight_to: @tariff.weight_to } }, as: :json
    end

    assert_response 201
  end

  test "should show tariff" do
    get tariff_url(@tariff), as: :json
    assert_response :success
  end

  test "should update tariff" do
    patch tariff_url(@tariff), params: { tariff: { currency_id: @tariff.currency_id, days: @tariff.days, delivery_id: @tariff.delivery_id, mode: @tariff.mode, price: @tariff.price, price_from: @tariff.price_from, price_to: @tariff.price_to, weight_from: @tariff.weight_from, weight_to: @tariff.weight_to } }, as: :json
    assert_response 200
  end

  test "should destroy tariff" do
    assert_difference('Tariff.count', -1) do
      delete tariff_url(@tariff), as: :json
    end

    assert_response 204
  end
end
