require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
    @new_project = Project.new(name: "newproject", space_name: "newproject")
  end

  test "visiting the index" do
    visit projects_url
    assert_selector "h1", text: "Projects"
  end

  test "should create project" do
    visit projects_url
    click_on "New project"

    fill_in "Name", with: @new_project.name
    fill_in "Space name", with: @new_project.space_name
    fill_in "Url preffix", with: @new_project.url_preffix
    click_on "Create Project"

    assert_text "Project was successfully created"
    click_on "Projects"
  end

  test "should update Project" do
    visit project_url(@project)
    click_on "Edit details", match: :first

    fill_in "Name", with: @project.name
    fill_in "Space name", with: @project.space_name
    fill_in "Url preffix", with: @project.url_preffix
    click_on "Update Project"

    assert_text "Project was successfully updated"
    click_on "Projects"
  end

  test "should visit endpoints" do
    visit project_url(@project)
    click_on "Endpoints", match: :first

    assert_selector "h1", text: "Endpoints"
  end

  test "should destroy Project" do
    visit project_url(@project)
    click_on "Destroy", match: :first

    assert_text "Project was successfully destroyed"
  end
end
