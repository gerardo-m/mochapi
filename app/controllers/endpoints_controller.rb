class EndpointsController < ApplicationController
  include VariableLister
  before_action :set_endpoint, only: %i[ show edit update destroy fetch_curl_code variables]

  # GET /endpoints or /endpoints.json
  def index
    project_id = params.expect(:project_id)
    @endpoints = Endpoint.where(project_id: project_id)
  end

  # GET /endpoints/1 or /endpoints/1.json
  def show
  end

  # GET /endpoints/new
  def new
    @endpoint = Endpoint.create_default(project_id: params[:project_id])
    @endpoint.save!
    redirect_to edit_endpoint_path(@endpoint, new: true)
  end

  # GET /endpoints/1/edit
  def edit
  end

  # POST /endpoints or /endpoints.json
  def create
    # @endpoint = Endpoint.new(endpoint_params)
    # @endpoint.responses << build_response
    # respond_to do |format|
    #   if @endpoint.save
    #     format.html { redirect_to endpoint_url(id: @endpoint.id), notice: "Endpoint was successfully saved." }
    #     format.json { render :show, status: :created, location: @endpoint }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @endpoint.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /endpoints/1 or /endpoints/1.json
  def update
    @endpoint.assign_attributes(endpoint_params)
    respond_to do |format|
      if @endpoint.update(endpoint_params)
        format.html { redirect_to project_endpoints_path(project_id: @endpoint.project_id), notice: "Endpoint was successfully saved." }
        format.json { render :show, status: :ok, location: project_endpoints_path(project_id: @endpoint.project_id) }
        format.turbo_stream { flash.now[:notice] = "Endpoint was successfully saved." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /endpoints/1 or /endpoints/1.json
  def destroy
    project_id = @endpoint.project_id
    @endpoint.destroy!

    respond_to do |format|
      format.html { redirect_to project_endpoints_path(project_id: project_id), status: :see_other, notice: "Endpoint was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def fetch_path_params
    template = Addressable::Template.new(params[:path])
    @path_params = template.variables
    render layout: false
  end

  def fetch_curl_code
    apiurl = params[:path].blank? ? "/" : params[:path]
    apiurl = @endpoint.project.url_preffix + "/" + apiurl if @endpoint.project.url_preffix.present?
    url = api_url(project: @endpoint.project.space_name, apiurl: apiurl)
    @curl_code ="curl -X #{@endpoint.method} #{URI::Parser.new.unescape(url)}"
    render plain: @curl_code, layout: false
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      @endpoint = Endpoint.find(params.expect(:id))
      @endpoint.default_response.plain_response
    end

    # Only allow a list of trusted parameters through.
    def endpoint_params
      params.expect(endpoint: [ :id, :name, :path, :method, :project_id ])
    end
end
