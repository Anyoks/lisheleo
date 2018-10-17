json.extract! sm, :id, :message, :phone_number, :created_at, :updated_at
json.url sms_url(sms, format: :json)
