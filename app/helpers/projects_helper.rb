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
    if action == "variables"
      return "Variables"
    end
    @project.name
  end

  def breadcrumb_links
    action = params[:action]
    links = []
    unless COLLECTION_ACTIONS.include?(action)
      links << KeyValue.new("Projects", projects_path)
    end
    if action == "variables"
      links << KeyValue.new(@project.name, edit_project_path(@project))
    end
    links
  end

  def is_new_record?
    params[:new].present?
  end
end
