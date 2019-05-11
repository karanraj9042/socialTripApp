#Controller for weather 
class CustomweathersController < ApplicationController
 # before_action :set_customweather, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_user!

  # GET /customweathers
  # GET /customweathers.json
  def index
    @trip = Trip.find(params[:trip_id])
  end
end
