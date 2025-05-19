require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
    @new_project = Project.new(name: "newproject", space_name: "newproject")
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_redirected_to %r{/projects/[0-9]*/edit}
  end

  test "should create project" do
    assert_difference("Project.count") do
      post projects_url, params: { project: { name: @new_project.name, space_name: @new_project.space_name, url_preffix: @project.url_preffix } }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { name: @project.name, space_name: @project.space_name, url_preffix: @project.url_preffix } }
    assert_redirected_to projects_url
  end

  test "should destroy project" do
    assert_difference("Project.count", -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
