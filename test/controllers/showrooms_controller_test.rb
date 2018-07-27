require 'test_helper'

class ShowroomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @showroom = showrooms(:one)
  end

  test "should get index" do
    get showrooms_url, as: :json
    assert_response :success
  end

  test "should create showroom" do
    assert_difference('Showroom.count') do
      post showrooms_url, params: { showroom: { description: @showroom.description, mana: @showroom.mana, owner_id: @showroom.owner_id, owner_type: @showroom.owner_type } }, as: :json
    end

    assert_response 201
  end

  test "should show showroom" do
    get showroom_url(@showroom), as: :json
    assert_response :success
  end

  test "should update showroom" do
    patch showroom_url(@showroom), params: { showroom: { description: @showroom.description, mana: @showroom.mana, owner_id: @showroom.owner_id, owner_type: @showroom.owner_type } }, as: :json
    assert_response 200
  end

  test "should destroy showroom" do
    assert_difference('Showroom.count', -1) do
      delete showroom_url(@showroom), as: :json
    end

    assert_response 204
  end
end
