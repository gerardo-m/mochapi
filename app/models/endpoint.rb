class Endpoint < ApplicationRecord
  belongs_to :project
  has_one :response, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :response

  def parsed_path
    @parsed_path ||= EndpointPaths::RegisteredPath.new(self.path)
    @parsed_path
  end
end
