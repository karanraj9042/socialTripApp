json.extract! trip, :id, :destination, :startdate, :enddate, :latitude, :longitude, :created_at, :updated_at
json.url trip_url(trip, format: :json)
