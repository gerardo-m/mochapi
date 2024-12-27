class Endpoint < ApplicationRecord
  belongs_to :project
  has_one :response
  accepts_nested_attributes_for :response
end
