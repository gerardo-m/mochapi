class Endpoint < ApplicationRecord
  belongs_to :project
  has_one :response
end
