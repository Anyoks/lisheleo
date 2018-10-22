json.extract! booking, :id, :time, :date, :description, :status, :confirm_status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
