json.extract! project, :id, :name, :space_name, :url_preffix, :created_at, :updated_at
json.url project_url(project, format: :json)
