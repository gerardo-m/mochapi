class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  def index
  end

  def new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: "Response was successfully saved." }
        format.json { render :show, status: :ok, location: @response }
        format.turbo_stream { flash.now[:notice] = "Response was successfully saved." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def show
  end

  private

  def set_response
    @response = Response.find(params.expect(:id))
  end

  def response_params
    params.permit(:response)
  end
end
