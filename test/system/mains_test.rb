require "application_system_test_case"

class MainsTest < ApplicationSystemTestCase
  setup do
    @user = users(:u1)
  end
  

  test "login_success" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 12345
    click_button "Login"
    assert_selector "h1" , text:"Welcome ".concat(@user.name)
  end

  test "login_failed_email" do
    visit "/main"
    fill_in "Email", with: "bacon2"
    fill_in "Password", with: 12345
    click_button "Login"
    assert_selector id:"alert" , text:"Wrong email"
  end

  test "login_failed_password" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 123456
    click_button "Login"
    assert_selector id:"alert" , text:"Wrong password"
  end

end