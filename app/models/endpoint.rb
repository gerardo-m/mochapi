class Endpoint < ApplicationRecord
  include NameSequenciable
  belongs_to :project
  has_many :responses, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :responses

  def self.create_default(project_id: nil)
    new_endpoint = Endpoint.new
    new_endpoint.name = next_titleized_name(:name)
    new_endpoint.method = "GET"
    response = Response.new responseable: PlainResponse.new
    new_endpoint.responses << response
    new_endpoint.project_id = project_id
    new_endpoint
  end

  def default_response
    self.responses.first
  end
end
