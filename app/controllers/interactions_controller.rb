class InteractionsController < ApplicationController
  before_action :set_interaction, only: [:show, :edit, :update, :destroy]

  # GET /interactions
  # GET /interactions.json
  def index
    @interactions = Interaction.all.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /interactions/1
  # GET /interactions/1.json
  def show
  end

  # GET /interactions/new
  def new
    @interaction = Interaction.new
    @client = Client.find(params[:client_id])
  end

  # GET /interactions/1/edit
  def edit
  end

  # POST /interactions
  # POST /interactions.json
  def create
    @client = Client.find(params[:interaction][:client_id])
    @interaction = Interaction.new(interaction_params)

    respond_to do |format|
      if @interaction.save
        format.html { redirect_to client_interactions_path(@client), notice: 'Interaction was successfully created.' }
        format.json { render :show, status: :created, location: @interaction }
      else
        format.html { render :new }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interactions/1
  # PATCH/PUT /interactions/1.json
  def update
    respond_to do |format|
      if @interaction.update(interaction_params)
        format.html { redirect_to client_interaction_path(@client), notice: 'Interaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @interaction }
      else
        format.html { render :edit }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interactions/1
  # DELETE /interactions/1.json
  def destroy
    @interaction.destroy
    respond_to do |format|
      format.html { redirect_to client_interactions_path(@client), notice: 'Interaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params[:id])
      @client = Client.find(params[:client_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interaction_params
      params.require(:interaction).permit(:name, :description, :date, :client_id)
    end
end
