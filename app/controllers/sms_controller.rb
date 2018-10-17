class SmsController < ApplicationController
  before_action :set_sms, only: [:show, :edit, :update, :destroy]

  # GET /sms
  # GET /sms.json
  def index
    @sms = Sms.all
  end

  # GET /sms/1
  # GET /sms/1.json
  def show
  end

  # GET /sms/new
  def new
    @sms = Sms.new
  end

  # GET /sms/1/edit
  def edit
  end

  # POST /sms
  # POST /sms.json
  def create
    @sms = Sms.new(sms_params)

    respond_to do |format|
      if @sms.save
        format.html { redirect_to @sms, notice: 'Sms was successfully created.' }
        format.json { render :show, status: :created, location: @sms }
      else
        format.html { render :new }
        format.json { render json: @sms.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms/1
  # PATCH/PUT /sms/1.json
  def update
    respond_to do |format|
      if @sms.update(sms_params)
        format.html { redirect_to @sms, notice: 'Sms was successfully updated.' }
        format.json { render :show, status: :ok, location: @sms }
      else
        format.html { render :edit }
        format.json { render json: @sms.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms/1
  # DELETE /sms/1.json
  def destroy
    @sms.destroy
    respond_to do |format|
      format.html { redirect_to sms_url, notice: 'Sms was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sms
      @sms = Sms.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_params
      params.require(:sms).permit(:message, :phone_number)
    end
end
