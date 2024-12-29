module ProjectsHelper
  COLLECTION_ACTIONS=[ "index" ]

  def breadcrumb_current
    action = params[:action]
    if COLLECTION_ACTIONS.include?(action)
      return "Projects"
    end
    if action == "new"
      return "New project"
    end
    @project.name
  end

  def breadcrumb_links
    action = params[:action]
    unless COLLECTION_ACTIONS.include?(action)
      return [ KeyValue.new("Projects", projects_path) ]
    end
    []
  end
end
