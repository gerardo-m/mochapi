module EndpointsHelper
  COLLECTION_ACTIONS=[ "index" ]

  def breadcrumb_links
    action = params[:action]
    project = Project.find(params[:project_id])
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
    url = api_url(project: endpoint.project.space_name, apiurl: endpoint.path)
    "curl -X #{endpoint.method} #{url}"
  end
end
