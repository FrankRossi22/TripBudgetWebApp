require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get quickSplit" do
    get static_pages_quickSplit_url
    assert_response :success
  end
end
