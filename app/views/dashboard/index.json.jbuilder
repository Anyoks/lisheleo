json.array! @bookings do |booking| #, partial: 'bookings/booking', as: :booking
    json.extract! booking, :id #:name, :code, :attachment
    json.title booking.description
    json.start booking.time
    json.end  booking.time
    
    # add colours for confirmed bookings etc.
    unless booking.program == nil
        if booking.program.code == "B1"
            json.color '#257e4a'
        elsif booking.program.code == "B2"
            json.color '#f39c12'
        elsif booking.program.code == "B3"
            json.color '#0073b7'
        else #B4
            json.color '#00c0ef'
        end
    end
    
    json.url booking_url(booking, format: :html)
end