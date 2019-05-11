require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "must create a Profile when valid data is provided" do
      profile = profiles(:one)
      assert_equal(true, profile.save, "must create a Profile when valid data is provided!")
     end
     
     
     test "must not create a Profile when firstname is not provided" do
      profile = profiles(:two)
      assert_equal(false, profile.save, "must not create a Profile when firstname is not provided!")
     end
     
     test "must not create a Profile when lastname is not provided" do
      profile = profiles(:three)
      assert_equal(false, profile.save, "must not create a Profile when lastname is not provided!")
     end
     
     test "must not create a Profile when likedevent is not provided" do
      profile = profiles(:fourth)
      assert_equal(false, profile.save, "must not create a Profile when likedevent is not provided!")
     end
     
     test "must not create a Profile when likedvenue is not provided" do
      profile = profiles(:fifth)
      assert_equal(false, profile.save, "must not create a Profile when likedvenue is not provided!")
     end
     test "must not create a Profile when address is not provided" do
      profile = profiles(:sixth)
      assert_equal(false, profile.save, "must not create a Profile when address is not provided!")
     end
     
     test "must not create a Profile with null user when user is not provided" do
      profile = profiles(:seventh)
      assert_equal(false, profile.save, "must not create a Profile with null user when user is not provided!")
     end
     
     
      
end
