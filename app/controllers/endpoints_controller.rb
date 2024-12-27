class EndpointsController < ApplicationController
  before_action :set_endpoint, only: %i[ show edit update destroy ]

  # GET /endpoints or /endpoints.json
  def index
    @endpoints = Endpoint.all
  end

  # GET /endpoints/1 or /endpoints/1.json
  def show
  end

  # GET /endpoints/new
  def new
    @endpoint = Endpoint.new
    @endpoint.response = Response.new responseable: PlainResponse.new
    @endpoint.project_id = params[:project_id]
  end

  # GET /endpoints/1/edit
  def edit
  end

  # POST /endpoints or /endpoints.json
  def create
    @endpoint = Endpoint.new(endpoint_params)

    respond_to do |format|
      if @endpoint.save
        format.html { redirect_to project_endpoint_url(id: @endpoint.id), notice: "Endpoint was successfully created." }
        format.json { render :show, status: :created, location: @endpoint }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endpoints/1 or /endpoints/1.json
  def update
    respond_to do |format|
      if @endpoint.update(endpoint_params)
        format.html { redirect_to project_endpoint_url(@endpoint), notice: "Endpoint was successfully updated." }
        format.json { render :show, status: :ok, location: @endpoint }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endpoints/1 or /endpoints/1.json
  def destroy
    @endpoint.destroy!

    respond_to do |format|
      format.html { redirect_to project_endpoints_path, status: :see_other, notice: "Endpoint was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      @endpoint = Endpoint.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def endpoint_params
      params.expect(endpoint: [ :name, :url, :project_id ])
    end
end
