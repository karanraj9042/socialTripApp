require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest  
  include Devise::Test::IntegrationHelpers
  
  setup do
    @trip = trips(:one)
    
  end

  test "should get index" do
    sign_in users(:one)
    get trips_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_trip_url
    assert_response :success
  end

  test "should create trip" do
    sign_in users(:one)
    assert_difference('Trip.count') do
      post trips_url, params: { trip: { destination: @trip.destination, enddate: @trip.enddate, latitude: @trip.latitude, longitude: @trip.longitude, startdate: @trip.startdate } }
    end

    assert_redirected_to trip_url(Trip.last)
  end

  test "should show trip" do
    sign_in users(:one)
    get trip_url(@trip)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_trip_url(@trip)
    assert_response :success
  end

  test "should update trip" do
    sign_in users(:one)
    patch trip_url(@trip), params: { trip: { destination: @trip.destination, enddate: @trip.enddate, latitude: @trip.latitude, longitude: @trip.longitude, startdate: @trip.startdate } }
    assert_redirected_to trip_url(@trip)
  end

  test "should destroy trip" do
    sign_in users(:one)
    assert_difference('Trip.count', -1) do
      delete trip_url(@trip)
    end

    assert_redirected_to trips_url
  end
end
