class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    # byebug
    if @booking.sms_id == nil
      @booking.sms = Sms.where(message: "dashboard_booking").first_or_create
    end

    eligible  			= @booking.check_booking_eligibility
    respond_to do |format|

      if eligible.class != Array

        if @booking.save
          # f ormat.html { redirect_to '/dashboard', notice: 'Booking was successfully created.' }
          format.json { render :show, status: :created, location: @booking }
          format.js # { render json: @booking, status: :unprocessable_entity  }
        else
          # format.html { render new }
         
          format.json { render json: @booking.errors, status: :unprocessable_entity }
          
          format.js { render json: @booking.errors, status: :unprocessable_entity  }
         
        end
      else
       
        message = "Slot unavailable. Try "
         eligible[1].each do |day,time|
          message = message + " " + day
          time.each do | at |
           message = message + ", " + at
          end
         end
        array = [message.strip]
        hash = {"errors" => array}

        format.json { render json:  hash, status: :unprocessable_entity }
          
        format.js { render json:  hash, status: :unprocessable_entity  }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:time, :date, :end_time,:client_id, :program_id ,:description, :status, :confirm_status)
    end
end
