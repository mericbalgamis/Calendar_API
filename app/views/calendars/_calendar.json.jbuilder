json.extract! calendar, :id, :title, :content, :location, :start_date, :start_time, :end_date, :end_time, :repeat, :reminder, :created_at, :updated_at
json.url calendar_url(calendar, format: :json)
