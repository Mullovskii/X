require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "should get index" do
    get comments_url, as: :json
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { author_id: @comment.author_id, author_type: @comment.author_type, body: @comment.body, commented_id: @comment.commented_id, commented_type: @comment.commented_type, url: @comment.url } }, as: :json
    end

    assert_response 201
  end

  test "should show comment" do
    get comment_url(@comment), as: :json
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { author_id: @comment.author_id, author_type: @comment.author_type, body: @comment.body, commented_id: @comment.commented_id, commented_type: @comment.commented_type, url: @comment.url } }, as: :json
    assert_response 200
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment), as: :json
    end

    assert_response 204
  end
end
