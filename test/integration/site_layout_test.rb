require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get signup_path
    assert_select "title", full_title("Sign up")
    get login_path
    assert_select "a[href=?]", signup_path

    log_in_as(@admin)
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_path(@admin)
    delete logout_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", edit_user_path(@admin), count: 0
  end
end
