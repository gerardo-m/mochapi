require "test_helper"

class EndpointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint = endpoints(:one)
    # @endpoint.response = responses(:one)
    # @endpoint.response.responseable = plain_responses(:one)
  end

  test "should get index" do
    get project_endpoints_url(project_id: @endpoint.project_id)
    assert_response :success
  end

  test "should get new" do
    get new_project_endpoint_url(project_id: @endpoint.project_id)
    assert_redirected_to %r{/endpoints/[0-9]*/edit}
  end

  test "should show endpoint" do
    get endpoint_url(@endpoint, project_id: @endpoint.project_id)
    assert_response :success
  end

  test "should get edit" do
    get edit_endpoint_url(@endpoint, project_id: @endpoint.project_id)
    assert_response :success
  end

  test "should update endpoint" do
    patch endpoint_url(@endpoint, project_id: @endpoint.project_id), params: { endpoint: { name: @endpoint.name, project_id: @endpoint.project_id, path: @endpoint.path } }
    assert_redirected_to project_endpoints_url(project_id: @endpoint.project_id)
  end

  test "should destroy endpoint" do
    assert_difference("Endpoint.count", -1) do
      delete endpoint_url(@endpoint, project_id: @endpoint.project_id)
    end

    assert_redirected_to project_endpoints_url(project_id: @endpoint.project_id)
  end
end
