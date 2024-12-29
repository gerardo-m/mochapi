require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  def setup
    @disposable_response = responses(:to_destroy)
  end

  test "responseable should be destroyed along the response" do
    plain_response_id = @disposable_response.responseable_id
    @disposable_response.destroy
    assert_raises(ActiveRecord::RecordNotFound) { PlainResponse.find(plain_response_id) }
  end

  test "solve method is delegated to responseable" do
  end
end
