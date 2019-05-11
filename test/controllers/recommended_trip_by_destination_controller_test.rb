require 'test_helper'

class RecommendedTripByDestinationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @trip = trips(:one)
  end
  
  test "should get allUser" do
    sign_in users(:one)
  end
  
  test "should get AllTripsForUser" do
    sign_in users(:one)
  end  
    
  
  
  
end
