json.extract! profile, :id, :firstname, :lastname, :likedevent, :likedvenue, :address, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
