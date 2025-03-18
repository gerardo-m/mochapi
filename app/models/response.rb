class Response < ApplicationRecord
  delegated_type :responseable, types: %w[ PlainResponse ], dependent: :destroy
  belongs_to :endpoint
  has_one :expression, as: :conditionable, autosave: true, dependent: :destroy
  # solve should return an object that could be sent to the render method
  delegate :solve, to: :responseable
  accepts_nested_attributes_for :responseable
  accepts_nested_attributes_for :expression

  # Contrary to what the name can imply, this will not create THE Default
  # response for an endpoint, it will instead create a default EXTRA response.
  #
  # That means this will create Response 1, Response 2... and  so on.
  #
  # The other thing that this will create is a root Expression, which THE
  # Default response of an endpoint doesn't have.
  def self.create_default(endpoint_id = nil)
    response = Response.new
    response.endpoint_id = endpoint_id
    order_number = Response.where(endpoint_id: endpoint_id).maximum(:order_number) || 0
    response.order_number = order_number + 1
    response.responseable = PlainResponse.new
    response.expression = Expression.new
    response
  end

  # returns a KeyValue array
  def endpoint_vars
    endpoint.parsed_path.params.map { |par| KeyValue.new(par.name, par.value) }
  end

  def is_default?
    order_number == 0
  end

  def conditions_met?(path_params)
    return expression.is_met?(path_params) unless expression.nil?
    false
  end
end
