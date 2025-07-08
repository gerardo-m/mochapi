class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  def index
  end

  def new
    @response = Response.create_default(params.expect(:endpoint_id))
    @response.save!
    respond_to do |format|
      format.turbo_stream { redirect_to edit_response_path(@response) }
    end
  end

  def edit
  end

  def update
    @response.assign_attributes(response_params)
    assign_responseable_attributes
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: "Response was successfully saved." }
        format.json { render :show, status: :ok, location: @response }
        format.turbo_stream { flash.now[:notice] = "Response was successfully saved." }
      else
        puts @response.errors
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @response.destroy!
  end

  def show
  end

  private

  def set_response
    @response = Response.find(params.expect(:id))
  end

  def response_params
    params.expect(response: [ :responseable_type, :status_code ])
  end

  def responseable_params
    response_permitted = []
    Response.responseable_types.each do |rtype|
      name = rtype.underscore.to_sym
      column_names = rtype.constantize.column_names
      column_names = column_names.reject { |cn| [ "created_at", "updated_at", "id" ].include?(cn) }
      column_names.map! { |cn| cn.to_sym }
      p = {}
      p[name] = column_names
      response_permitted << p
    end
    params.expect(response: response_permitted)
  end

  def assign_responseable_attributes
    Response.responseable_types.each do |rtype|
      if @response.send("#{rtype.underscore}?")
        responseable = @response.send("#{rtype.underscore}")
        responseable.assign_attributes(responseable_params[rtype.underscore.to_sym])
        return
      end
    end
  end
end
