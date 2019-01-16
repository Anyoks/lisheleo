json.array! @bookings do |booking| #, partial: 'bookings/booking', as: :booking
    json.extract! booking, :id #:name, :code, :attachment
    json.title booking.description
    json.start booking.time
    json.end  booking.end_time
    # json.color booking.program.color
    # add colours for confirmed bookings etc.
    if booking.program == nil
        json.color '#257e4a'
    else
        # if booking.program.code == "B1"
            json.color booking.program.color
            # json.color '#257e4a'
        # elsif booking.program.code == "B2"
        #     json.color '#f39c12'
        # elsif booking.program.code == "B3"
        #     json.color '#0073b7'
        # else #B4
        #     json.color '#00c0ef'
        # end
    end
    
    json.url booking_url(booking, format: :html)
end