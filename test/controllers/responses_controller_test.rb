require "test_helper"

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @response1 = responses(:one)
    @response_to_destroy = responses(:to_destroy)
  end


  test "should get index" do
    get endpoint_responses_url(endpoint_id: @response1.endpoint_id)
    assert_response :success
  end

  # test "should get new" do
  #   get new_endpoint_response_url(endpoint_id: @response1.endpoint_id)
  #   assert_response :success
  # end

  test "should get edit" do
    get edit_response_url(@response1)
    assert_response :success
  end

  # test "should get update" do
  #   patch response_url(@response1)
  #   assert_redirected_to response_url(@response1)
  # end

  # test "should get destroy" do
  #   delete response_url(@response_to_destroy)
  #   assert_response :success
  # end

  test "should get show" do
    get response_url(@response1)
    assert_response :success
  end
end
