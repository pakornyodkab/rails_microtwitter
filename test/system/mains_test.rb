require "application_system_test_case"

class MainsTest < ApplicationSystemTestCase
  setup do
    @user = users(:u1)
    @user2 = users(:u2)
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




  #create follow already in follows.yml
  test "follow post is show" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 12345
    click_button "Login"
    assert_selector "h1" , text:"Welcome ".concat(@user.name)
    assert_text "lebron"
    assert_text "test"
  end

  test "profileshowpost" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 12345
    click_button "Login"
    visit "profile/#{@user2.name}"
    assert_text "test"
  end

  test "Likework" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: 12345
    click_button "Login"
    click_on "Like" , match: :first
    assert_selector ".table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(5) > button:nth-child(1)" ,text:"1" #copy from CSS selector
    visit "profile/#{@user2.name}"
    assert_selector ".table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(4) > button:nth-child(1)" ,text:"1" #copy from CSS selector

  end


end