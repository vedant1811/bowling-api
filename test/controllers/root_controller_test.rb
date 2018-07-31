require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :ok
  end
end
