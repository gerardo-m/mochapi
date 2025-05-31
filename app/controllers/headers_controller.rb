class HeadersController < ApplicationController
  before_action :set_header, only: %i[destroy update edit]

  def new
    @response_id = params.expect(:response_id)
    @header = Header.create_default(response_id: @response_id)
    @header.save!
  end

  def destroy
    @header.destroy!
  end

  def edit
  end

  def update
    @header.update(headers_params)
  end

  private

  def set_header
    @header = Header.find(params.expect(:id))
  end

  def headers_params
    params.expect(header: [ :field, :value, :enabled ])
  end
end
