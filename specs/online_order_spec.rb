require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  # Arrange
  id = 1
  products = { "Lobster" => 17.18,
    "Annatto seed" => 58.38,
    "Camomile" => 83.21
  }
  customer_id = 25
  status = "complete"
  online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Assertion
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # Action
      result = online_order.customer_id
      # Assertion
      result.must_equal 25
    end

    it "Can access the online order status" do
      # Action
      result = online_order.status
      # Assertion
      result.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # Arrange
      total = 180.68
      # Action
      result = online_order.total
      # Assertion
      result.must_equal total
    end

    it "Doesn't add a shipping fee if there are no products" do
      # Arrange
      id_test = 1
      products_test = { }
      customer_id_test = 25
      status_test = "complete"
      total_test = 0
      empty_order = Grocery::OnlineOrder.new(id_test, products_test, customer_id_test, status_test)
      # Action
      result = empty_order.total
      # Assertion
      result.must_equal total_test
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # Action
      result = online_order.add_product("banana", 7.55)
      # Assertion
      result.must_equal ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # Arrange
      id_test = 1
      products_test = {
        "Lobster" => 17.18,
        "Annatto seed" => 58.38,
        "Camomile" => 83.21
      }
      customer_id_test = 25
      status_test = "pending"
      test_order = Grocery::OnlineOrder.new(id_test, products_test, customer_id_test, status_test)
      # Action
      result = test_order.add_product("Guacamole", 7.55)
      # Assertion
      result.must_equal test_order.products["Guacamole"]
    end
  end

  describe "OnlineOrder.all" do
    online_orders = Grocery::OnlineOrder.all
    it "Returns an array of all online orders" do
      online_orders.class.must_equal Array
    end

    it "Returns accurate information about the first online order" do
      id = 1
      products = {
        "Lobster" => 17.18,
        "Annatto seed" => 58.38,
        "Camomile" => 83.21
      }
      customer_id = 25
      status = :complete

      online_orders.first.id.must_equal id
      online_orders.first.products.must_equal products
      online_orders.first.customer_id.must_equal customer_id
      online_orders.first.status.must_equal status
    end

    it "Returns accurate information about the last online order" do
      id = 100
      products = {
        "Amaranth" => 83.81,
        "Smoked Trout" => 70.6,
        "Cheddar" => 5.63
      }
      customer_id = 20
      status = :pending

      online_orders.last.id.must_equal id
      online_orders.last.products.must_equal products
      online_orders.last.customer_id.must_equal customer_id
      online_orders.last.status.must_equal status
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
