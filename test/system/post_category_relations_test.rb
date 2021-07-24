require "application_system_test_case"

class PostCategoryRelationsTest < ApplicationSystemTestCase
  setup do
    @post_category_relation = post_category_relations(:one)
  end

  test "visiting the index" do
    visit post_category_relations_url
    assert_selector "h1", text: "Post Category Relations"
  end

  test "creating a Post category relation" do
    visit post_category_relations_url
    click_on "New Post Category Relation"

    fill_in "Category", with: @post_category_relation.category_id
    fill_in "Post", with: @post_category_relation.post_id
    click_on "Create Post category relation"

    assert_text "Post category relation was successfully created"
    click_on "Back"
  end

  test "updating a Post category relation" do
    visit post_category_relations_url
    click_on "Edit", match: :first

    fill_in "Category", with: @post_category_relation.category_id
    fill_in "Post", with: @post_category_relation.post_id
    click_on "Update Post category relation"

    assert_text "Post category relation was successfully updated"
    click_on "Back"
  end

  test "destroying a Post category relation" do
    visit post_category_relations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post category relation was successfully destroyed"
  end
end
