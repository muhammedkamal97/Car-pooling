json.extract! location, :id, :day, :fromAddress, :from_lat, :from_long, :toAddress, :to_lat, :to_long, :time, :user_id, :created_at, :updated_at
json.url location_url(location, format: :json)
