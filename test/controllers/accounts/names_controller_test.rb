require 'test_helper'

class Accounts::NamesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get accounts_names_edit_url
    assert_response :success
  end

  test "should get update" do
    get accounts_names_update_url
    assert_response :success
  end

end
