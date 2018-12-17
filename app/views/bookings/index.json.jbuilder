json.array! @bookings do |booking| #, partial: 'bookings/booking', as: :booking
    json.extract! booking, :id #:name, :code, :attachment
    json.title booking.description
    json.start booking.time
    json.end  booking.time 
    json.color '#257e4a'
    json.url booking_url(booking, format: :html)
end