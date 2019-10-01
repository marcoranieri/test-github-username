require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase

  test "visiting the index page" do
    visit root_url
    # save_and_open_screenshot

    assert_selector "h3", text: "TITLE"
    assert_selector ".my-card", count: 1
  end

  test "testing INPUT field and Show page" do
    visit "/"

    fill_in "username", with: "marcoranieri"

    click_on 'Search'
    # save_and_open_screenshot

    assert_equal show_path("marcoranieri"), page.current_path
    assert_text "marcoranieri"
  end

  test "GitHub link has a valid HREF" do
    visit show_path("marcoranieri")

    page.assert_selector(:css, 'a[href="https://github.com/marcoranieri"]')
  end

end
