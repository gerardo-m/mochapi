require "application_system_test_case"

class EndpointsTest < ApplicationSystemTestCase
  setup do
    @endpoint = endpoints(:one)
  end

  test "visiting the index" do
    visit project_endpoints_url(project_id: @endpoint.project_id)
    assert_selector "h1", text: "Endpoints"
  end

  test "should create endpoint" do
    visit project_endpoints_url(project_id: @endpoint.project_id)
    click_on "New endpoint"

    fill_in "Name", with: @endpoint.name
    fill_in "Path", with: @endpoint.path
    click_on "Create Endpoint"

    assert_text "Endpoint was successfully created"
    click_on "Endpoints"
  end

  test "should update Endpoint" do
    visit project_endpoint_url(@endpoint, project_id: @endpoint.project_id)
    click_on "Edit this endpoint", match: :first

    fill_in "Name", with: @endpoint.name
    fill_in "Path", with: @endpoint.path
    click_on "Update Endpoint"

    assert_text "Endpoint was successfully updated"
    click_on "Endpoints"
  end

  test "should destroy Endpoint" do
    visit project_endpoint_url(@endpoint, project_id: @endpoint.project_id)
    click_on "Destroy", match: :first

    assert_text "Endpoint was successfully destroyed"
  end
end
