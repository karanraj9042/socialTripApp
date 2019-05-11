require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @comment = comments(:one)
    @message = messages(:one)
  end

  
  test "should get new" do
    sign_in users(:one)
    get new_message_url
    assert_response :success
  end

  # test "should create comment" do
  #   sign_in users(:one)
  #   assert_difference('Comment.count') do
  #     post message_url, params: { comment: { message: @message.title, content: @comment.content, message_id: @comment.message_id, user_id: @comment.user_id } }
  #   end

  #   assert_redirected_to message_comment_path(@comment.message, @comment)
  # end


  test "should get edit" do
    sign_in users(:one)
    get edit_message_comment_path(@comment.message, @comment)
    assert_response :success
  end

  test "should update comment" do
    sign_in users(:one)
    patch message_comment_path(@comment.message, @comment), params: { comment: { content: @comment.content, message_id: @comment.message_id, user_id: @comment.user_id } }
    assert_redirected_to message_path(@message)
  end

  test "should destroy comment" do
    sign_in users(:one)
    assert_difference('Comment.count', -1) do
      delete message_comment_path(@comment.message, @comment)
    end

    assert_redirected_to message_path(@message)
  end
end
