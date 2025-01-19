class Endpoint < ApplicationRecord
  include NameSequenciable
  belongs_to :project
  has_one :response, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :response

  def self.create_default(project_id: nil)
    new_endpoint = Endpoint.new
    new_endpoint.name = next_titleized_name(:name)
    new_endpoint.method = "GET"
    new_endpoint.response = Response.new responseable: PlainResponse.new
    new_endpoint.project_id = project_id
    new_endpoint
  end

  def parsed_path
    @parsed_path ||= EndpointPaths::RegisteredPath.new(self.path)
    @parsed_path
  end
end
