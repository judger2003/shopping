require "application_system_test_case"

class OrderProductsTest < ApplicationSystemTestCase
  setup do
    @order_product = order_products(:one)
  end

  test "visiting the index" do
    visit order_products_url
    assert_selector "h1", text: "Order products"
  end

  test "should create order product" do
    visit order_products_url
    click_on "New order product"

    fill_in "Order", with: @order_product.order_id
    fill_in "Product", with: @order_product.product_id
    fill_in "Quantity", with: @order_product.quantity
    click_on "Create Order product"

    assert_text "Order product was successfully created"
    click_on "Back"
  end

  test "should update Order product" do
    visit order_product_url(@order_product)
    click_on "Edit this order product", match: :first

    fill_in "Order", with: @order_product.order_id
    fill_in "Product", with: @order_product.product_id
    fill_in "Quantity", with: @order_product.quantity
    click_on "Update Order product"

    assert_text "Order product was successfully updated"
    click_on "Back"
  end

  test "should destroy Order product" do
    visit order_product_url(@order_product)
    click_on "Destroy this order product", match: :first

    assert_text "Order product was successfully destroyed"
  end
end
