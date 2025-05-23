class HeadersController < ApplicationController
  before_action :set_header, only: %i[destroy]

  def new
    @response_id = params.expect(:response_id)
    @header = Header.create_default(response_id: @response_id)
    @header.save!
  end

  def destroy
    @header.destroy!
  end

  private

  def set_header
    @header = Header.find(params.expect(:id))
  end
end
