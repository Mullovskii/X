require 'test_helper'

class BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = brands(:one)
  end

  test "should get index" do
    get brands_url, as: :json
    assert_response :success
  end

  test "should create brand" do
    assert_difference('Brand.count') do
      post brands_url, params: { brand: { avatar: @brand.avatar, background: @brand.background, description: @brand.description, main_category_id: @brand.main_category_id, main_country_id: @brand.main_country_id, mana: @brand.mana, name: @brand.name, status: @brand.status } }, as: :json
    end

    assert_response 201
  end

  test "should show brand" do
    get brand_url(@brand), as: :json
    assert_response :success
  end

  test "should update brand" do
    patch brand_url(@brand), params: { brand: { avatar: @brand.avatar, background: @brand.background, description: @brand.description, main_category_id: @brand.main_category_id, main_country_id: @brand.main_country_id, mana: @brand.mana, name: @brand.name, status: @brand.status } }, as: :json
    assert_response 200
  end

  test "should destroy brand" do
    assert_difference('Brand.count', -1) do
      delete brand_url(@brand), as: :json
    end

    assert_response 204
  end
end
