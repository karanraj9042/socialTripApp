require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest 
  include Devise::Test::IntegrationHelpers
 
  
setup do
   @profile = profiles(:one)
  end


  test "should get index" do
    sign_in users(:one)
    get profiles_url
    assert_response :success
  end

  test "should get new" do
     sign_in users(:one)
    get new_profile_url
    assert_response :redirect
  end

  test "should create profile" do
     sign_in users(:one)
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { address: @profile.address, firstname: @profile.firstname, lastname: @profile.lastname, likedevent: @profile.likedevent, likedvenue: @profile.likedvenue, user_id: @profile.user_id } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
     sign_in users(:one)
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
     sign_in users(:one)
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
     sign_in users(:one)
    patch profile_url(@profile), params: { profile: { address: @profile.address, firstname: @profile.firstname, lastname: @profile.lastname, likedevent: @profile.likedevent, likedvenue: @profile.likedvenue, user_id: @profile.user_id } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
     sign_in users(:one)
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
