require "test_helper"

class ShippingInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_info = shipping_infos(:one)
  end

  test "should get index" do
    get shipping_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_shipping_info_url
    assert_response :success
  end

  test "should create shipping_info" do
    assert_difference("ShippingInfo.count") do
      post shipping_infos_url, params: { shipping_info: { address: @shipping_info.address, phone_number: @shipping_info.phone_number, postal_code: @shipping_info.postal_code, receiver: @shipping_info.receiver } }
    end

    assert_redirected_to shipping_info_url(ShippingInfo.last)
  end

  test "should show shipping_info" do
    get shipping_info_url(@shipping_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipping_info_url(@shipping_info)
    assert_response :success
  end

  test "should update shipping_info" do
    patch shipping_info_url(@shipping_info), params: { shipping_info: { address: @shipping_info.address, phone_number: @shipping_info.phone_number, postal_code: @shipping_info.postal_code, receiver: @shipping_info.receiver } }
    assert_redirected_to shipping_info_url(@shipping_info)
  end

  test "should destroy shipping_info" do
    assert_difference("ShippingInfo.count", -1) do
      delete shipping_info_url(@shipping_info)
    end

    assert_redirected_to shipping_infos_url
  end
end
