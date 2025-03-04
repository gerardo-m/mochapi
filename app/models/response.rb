class Response < ApplicationRecord
  delegated_type :responseable, types: %w[ PlainResponse ], dependent: :destroy
  belongs_to :endpoint
  has_one :expression, as: :conditionable
  # solve should return an object that could be sent to the render method
  delegate :solve, to: :responseable
  accepts_nested_attributes_for :responseable

  # returns a KeyValue array
  def endpoint_vars
    endpoint.parsed_path.params.map { |par| KeyValue.new(par.name, par.value) }
  end

  def is_default?
    order_number == 0
  end
end
