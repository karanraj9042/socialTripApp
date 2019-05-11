require "application_system_test_case"

class CaffesTest < ApplicationSystemTestCase
  setup do
    @caffe = caffes(:one)
  end

  test "visiting the index" do
    visit caffes_url
    assert_selector "h1", text: "Caffes"
  end

  test "creating a Caffe" do
    visit caffes_url
    click_on "New Caffe"

    click_on "Create Caffe"

    assert_text "Caffe was successfully created"
    click_on "Back"
  end

  test "updating a Caffe" do
    visit caffes_url
    click_on "Edit", match: :first

    click_on "Update Caffe"

    assert_text "Caffe was successfully updated"
    click_on "Back"
  end

  test "destroying a Caffe" do
    visit caffes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Caffe was successfully destroyed"
  end
end
