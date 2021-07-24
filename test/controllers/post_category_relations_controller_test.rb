require 'test_helper'

class PostCategoryRelationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_category_relation = post_category_relations(:one)
  end

  test "should get index" do
    get post_category_relations_url
    assert_response :success
  end

  test "should get new" do
    get new_post_category_relation_url
    assert_response :success
  end

  test "should create post_category_relation" do
    assert_difference('PostCategoryRelation.count') do
      post post_category_relations_url, params: { post_category_relation: { category_id: @post_category_relation.category_id, post_id: @post_category_relation.post_id } }
    end

    assert_redirected_to post_category_relation_url(PostCategoryRelation.last)
  end

  test "should show post_category_relation" do
    get post_category_relation_url(@post_category_relation)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_category_relation_url(@post_category_relation)
    assert_response :success
  end

  test "should update post_category_relation" do
    patch post_category_relation_url(@post_category_relation), params: { post_category_relation: { category_id: @post_category_relation.category_id, post_id: @post_category_relation.post_id } }
    assert_redirected_to post_category_relation_url(@post_category_relation)
  end

  test "should destroy post_category_relation" do
    assert_difference('PostCategoryRelation.count', -1) do
      delete post_category_relation_url(@post_category_relation)
    end

    assert_redirected_to post_category_relations_url
  end
end
