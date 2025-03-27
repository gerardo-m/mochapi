module EndpointsHelper
  COLLECTION_ACTIONS=[ "index" ]

  def breadcrumb_links
    action = params[:action]
    project_id = params[:project_id]
    project_id ||= @endpoint.project_id
    project = Project.find(project_id)
    links = [
      KeyValue.new("Projects", projects_path),
      KeyValue.new(project.name, project_path(project.id))
    ]
    unless COLLECTION_ACTIONS.include?(action)
      links << KeyValue.new("Endpoints", project_endpoints_path(project_id: project.id))
    end
    links
  end

  def breadcrumb_current
    action = params[:action]
    if COLLECTION_ACTIONS.include?(action)
      return "Endpoints"
    end
    if action == "new"
      return "New endpoint"
    end
    @endpoint.name
  end

  def curl_code(endpoint)
    apiurl = endpoint.path.blank? ? "/" : endpoint.path
    url = api_url(project: endpoint.project.space_name, apiurl: apiurl)
    "curl -X #{endpoint.method} #{URI::Parser.new.unescape(url)}"
  end

  def is_new_record?
    params[:new].present?
  end
end
