require 'test_helper'

class ConverstionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get converstions_index_url
    assert_response :success
  end

end
