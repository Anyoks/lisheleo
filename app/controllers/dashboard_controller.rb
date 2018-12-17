class DashboardController < ApplicationController
  def index
    @bookings = Booking.all
  end
end
