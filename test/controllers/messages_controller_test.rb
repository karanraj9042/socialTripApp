require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers
   
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    sign_in users(:one)
    get messages_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_message_url
    assert_response :success
  end

  # test "should create message" do
  #   sign_in users(:one)
  #   assert_difference('Message.count') do
  #     post messages_url, params: { message: { description: @message.description, title: @message.title } }
  #   end

  #   assert_redirected_to messages_path
  # end
  
  test "should update message" do
    sign_in users(:one)
    patch message_url(@message), params: { message: { description: @message.description, title: @message.title } }
    assert_response :success
  end

  test "should show message" do
    sign_in users(:one)
    get messages_url
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_message_url(@message)
    assert_response :success
  end


  test "should destroy message" do
    sign_in users(:one)
    assert_difference('Message.count', -1) do
      delete message_url(@message)
    end

    assert_redirected_to messages_url
  end
end
