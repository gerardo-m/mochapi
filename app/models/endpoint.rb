class Endpoint < ApplicationRecord
  include NameSequenciable
  include VariableHolder
  belongs_to :project
  has_many :responses, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :responses

  variable_holder_parent :project

  def self.create_default(project_id: nil)
    new_endpoint = Endpoint.new
    new_endpoint.name = next_titleized_name(:name, project_id: project_id)
    new_endpoint.method = Constants::SUPPORTED_METHODS.first
    response = Response.new responseable: PlainResponse.new
    new_endpoint.responses << response
    new_endpoint.project_id = project_id
    new_endpoint
  end

  def default_response
    self.responses.first
  end
end
