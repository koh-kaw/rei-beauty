require 'test_helper'

class BuserAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get buser_accounts_show_url
    assert_response :success
  end

end
