require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do
    @existing_project = projects(:one)
    @new_project = Project.new(name: "newproject", space_name: "newproject")
    @project_no_name = Project.new(space_name: "newproject")
    @project_no_space_name = Project.new(name: "newproject")
  end

  test "should not save project without name" do
    assert_not @project_no_name.save, "Saved project without name"
  end

  test "should not save project without space name" do
    assert_not @project_no_space_name.save, "Saved project without space name"
  end

  test "should not save project with existing name" do
    project = Project.new
    project.name = @existing_project.name
    project.space_name = "This is definitively new"
    assert_not project.save, "Saved project with an existing name"
  end

  test "should not save project with existing space name" do
    project = Project.new
    project.name = "Brand new name"
    project.space_name = @existing_project.space_name
    assert_not project.save, "Saved project with an existing space name"
  end
end
