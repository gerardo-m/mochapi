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
    click_on "Save"

    assert_text "Endpoint was successfully saved"
  end

  test "should update Endpoint" do
    visit edit_endpoint_url(@endpoint, project_id: @endpoint.project_id)

    fill_in "Name", with: @endpoint.name
    fill_in "Path", with: @endpoint.path
    click_on "Save"

    assert_text "Endpoint was successfully saved"
  end

  test "should destroy Endpoint" do
    visit endpoint_url(@endpoint, project_id: @endpoint.project_id)
    click_on "Destroy", match: :first

    assert_text "Endpoint was successfully destroyed"
  end
end
