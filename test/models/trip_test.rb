require 'test_helper'

class TripTest < ActiveSupport::TestCase
  
    test "must create a Trip when valid data is provided" do
      trip = trips(:one)
      assert_equal(true, trip.save, "must create a Trip when valid data is provided!")
     end
     
      test "must not create a Trip when end_date_is_after_start_date" do
      trip = trips(:two)
      assert_equal(false, trip.save, "must not create a Trip when end_date_is_after_start_date!")
     end
     
      test "must not create a Trip when locaton is invalid" do
      trip = trips(:three)
      assert_equal(false, trip.save, "must not create a Trip when locaton is invalid!")
     end
     
     test "must create a Trip when attached image count is less than 4" do
      trip = trips(:four)
      assert_equal(true, trip.save, "must create a Trip when attached image count is less than 4!")
     end
     
     test "must show a Trip when destination is searched" do
      trip = trips(:four)
      assert_equal(true, trip.save, "must show a Trip when destination is searched!")
     end
     
end
