json.extract! customweather, :id, :created_at, :updated_at
json.url customweather_url(customweather, format: :json)
