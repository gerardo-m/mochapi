require "test_helper"

class EndpointTest < ActiveSupport::TestCase
  setup do
    @existing_endpoint = endpoints(:one)
    @disposable_endpoint = endpoints(:to_destroy)
  end

  test "Endpoint's response should be destroyed along with the endpoint" do
    response_id = @disposable_endpoint.default_response.id
    @disposable_endpoint.destroy
    assert_raises(ActiveRecord::RecordNotFound) { Response.find(response_id) }
  end
end
