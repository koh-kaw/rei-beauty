require 'test_helper'

class Accounts::AvatarsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get accounts_avatars_edit_url
    assert_response :success
  end

  test "should get update" do
    get accounts_avatars_update_url
    assert_response :success
  end

end
