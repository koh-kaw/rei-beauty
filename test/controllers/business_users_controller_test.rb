require 'test_helper'

class BusinessUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get business_users_show_url
    assert_response :success
  end

end
