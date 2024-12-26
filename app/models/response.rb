class Response < ApplicationRecord
  delegated_type :responseable, types: %w[ PlainResponse ], dependent: :destroy
  belongs_to :endpoint
end
