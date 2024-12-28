class Response < ApplicationRecord
  delegated_type :responseable, types: %w[ PlainResponse ], dependent: :destroy
  belongs_to :endpoint
  delegate :solve, to: :responseable
  accepts_nested_attributes_for :responseable
end
