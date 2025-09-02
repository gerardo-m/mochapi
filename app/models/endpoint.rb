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

  def complete_path
    return path if project.url_preffix.blank? or path.blank?
    n_path = path.dup
    n_url_preffix = project.url_preffix.dup
    if n_path.start_with?("/")
      n_path = n_path[1..]
    end
    if n_path.end_with?("/")
      n_path = n_path[0..-2]
    end
    # do the same for the url preffix
    if n_url_preffix.start_with?("/")
      n_url_preffix = n_url_preffix[1..]
    end
    if n_url_preffix.end_with?("/")
      n_url_preffix = n_url_preffix[0..-2]
    end
    "#{n_url_preffix}/#{n_path}"
  end

  def default_response
    self.responses.first
  end
end
