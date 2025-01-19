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
    @endpoint = Endpoint.create_default(project_id: params[:project_id])
    @endpoint.save!
  end

  # GET /endpoints/1/edit
  def edit
  end

  # POST /endpoints or /endpoints.json
  def create
    @endpoint = Endpoint.new(endpoint_params)
    @endpoint.response = build_response
    respond_to do |format|
      if @endpoint.save
        format.html { redirect_to project_endpoint_url(id: @endpoint.id, project_id: @endpoint.project_id), notice: "Endpoint was successfully saved." }
        format.json { render :show, status: :created, location: @endpoint }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /endpoints/1 or /endpoints/1.json
  def update
    @endpoint.assign_attributes(endpoint_params)
    resassign_response
    respond_to do |format|
      if @endpoint.update(endpoint_params)
        format.html { redirect_to project_endpoint_url(@endpoint, project_id: @endpoint.project_id), notice: "Endpoint was successfully saved." }
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

  def fetch_path_params
    p = EndpointPaths::RegisteredPath.new(params[:path])
    @path_params = p.params.map { |p| p.name }
    render layout: false
  end

  private

    def resassign_response
      if params[:type]== "PlainResponse"
        if @endpoint.response.plain_response.nil?
          @endpoint.response.responseable = PlainResponse.new(response_params)
        else
          @endpoint.response.plain_response.assign_attributes(response_params)
        end
      end
    end

    def build_response
      if params[:type]== "PlainResponse"
        return Response.new responseable: PlainResponse.new(response_params)
      end
      nil
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      @endpoint = Endpoint.find(params.expect(:id))
      @endpoint.response.plain_response
    end

    # Only allow a list of trusted parameters through.
    def endpoint_params
      params.expect(endpoint: [ :id, :name, :path, :method, :project_id ])
    end

    def response_params
      r_params = params[:endpoint][:response_attributes]
      if params[:type]== "PlainResponse"
        return r_params.expect(plain_response: [ :content ])
      end
      rparams
    end
end
