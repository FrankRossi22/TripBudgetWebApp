json.extract! trip, :id, :Start_Date, :End_Date, :People, :created_at, :updated_at
json.url trip_url(trip, format: :json)
