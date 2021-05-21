require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.first.toggle!(:activated)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    
    assigns(:users).each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
  test "unsuccessful edit" do
    log_in_as(@non_admin)
    get edit_user_path(@non_admin)
    assert_template 'users/edit'
    patch user_path(@non_admin), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert", text: "The form contains 4 errors."
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@non_admin)
    assert_not_nil session[:forwarding_url]
    log_in_as(@non_admin)
    assert_redirected_to edit_user_path(@non_admin)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@non_admin), params: { user: { name:  name,
                                              email: email,
                                              password:              "foobar",
                                              password_confirmation: "foobar" } }
    assert_not flash.empty?
    assert_redirected_to @non_admin
    assert_nil session[:forwarding_url]
    @non_admin.reload
    assert_equal @non_admin.name,  name
    assert_equal @non_admin.email, email
  end
  
end
