class Endpoint < ApplicationRecord
  belongs_to :project
  has_one :response, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :response
end
