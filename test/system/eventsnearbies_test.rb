require "application_system_test_case"

class EventsnearbiesTest < ApplicationSystemTestCase
  setup do
    @eventsnearby = eventsnearbies(:one)
  end

  test "visiting the index" do
    visit eventsnearbies_url
    assert_selector "h1", text: "Eventsnearbies"
  end

  test "creating a Eventsnearby" do
    visit eventsnearbies_url
    click_on "New Eventsnearby"

    click_on "Create Eventsnearby"

    assert_text "Eventsnearby was successfully created"
    click_on "Back"
  end

  test "updating a Eventsnearby" do
    visit eventsnearbies_url
    click_on "Edit", match: :first

    click_on "Update Eventsnearby"

    assert_text "Eventsnearby was successfully updated"
    click_on "Back"
  end

  test "destroying a Eventsnearby" do
    visit eventsnearbies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Eventsnearby was successfully destroyed"
  end
end
