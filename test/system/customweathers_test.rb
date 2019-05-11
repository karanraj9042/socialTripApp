require "application_system_test_case"

class CustomweathersTest < ApplicationSystemTestCase
  setup do
    @customweather = customweathers(:one)
  end

  test "visiting the index" do
    visit customweathers_url
    assert_selector "h1", text: "Customweathers"
  end

  test "creating a Customweather" do
    visit customweathers_url
    click_on "New Customweather"

    click_on "Create Customweather"

    assert_text "Customweather was successfully created"
    click_on "Back"
  end

  test "updating a Customweather" do
    visit customweathers_url
    click_on "Edit", match: :first

    click_on "Update Customweather"

    assert_text "Customweather was successfully updated"
    click_on "Back"
  end

  test "destroying a Customweather" do
    visit customweathers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customweather was successfully destroyed"
  end
end
