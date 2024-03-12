require "application_system_test_case"

class ShippingInfosTest < ApplicationSystemTestCase
  setup do
    @shipping_info = shipping_infos(:one)
  end

  test "visiting the index" do
    visit shipping_infos_url
    assert_selector "h1", text: "Shipping infos"
  end

  test "should create shipping info" do
    visit shipping_infos_url
    click_on "New shipping info"

    fill_in "Address", with: @shipping_info.address
    fill_in "Phone number", with: @shipping_info.phone_number
    fill_in "Postal code", with: @shipping_info.postal_code
    fill_in "Receiver", with: @shipping_info.receiver
    click_on "Create Shipping info"

    assert_text "Shipping info was successfully created"
    click_on "Back"
  end

  test "should update Shipping info" do
    visit shipping_info_url(@shipping_info)
    click_on "Edit this shipping info", match: :first

    fill_in "Address", with: @shipping_info.address
    fill_in "Phone number", with: @shipping_info.phone_number
    fill_in "Postal code", with: @shipping_info.postal_code
    fill_in "Receiver", with: @shipping_info.receiver
    click_on "Update Shipping info"

    assert_text "Shipping info was successfully updated"
    click_on "Back"
  end

  test "should destroy Shipping info" do
    visit shipping_info_url(@shipping_info)
    click_on "Destroy this shipping info", match: :first

    assert_text "Shipping info was successfully destroyed"
  end
end
