class Response < ApplicationRecord
  delegated_type :responseable, types: %w[ PlainResponse ], dependent: :destroy
  belongs_to :endpoint
  has_one :expression, as: :conditionable
  # solve should return an object that could be sent to the render method
  delegate :solve, to: :responseable
  accepts_nested_attributes_for :responseable

  def self.create_default(endpoint_id=nil)
    response = Response.new
    response.endpoint_id = endpoint_id
    order_number = Response.where(endpoint_id: endpoint_id).maximum(:order_number) || 0
    response.order_number = order_number + 1
    response.responseable = PlainResponse.new
    response
  end

  # returns a KeyValue array
  def endpoint_vars
    endpoint.parsed_path.params.map { |par| KeyValue.new(par.name, par.value) }
  end

  def is_default?
    order_number == 0
  end
end
