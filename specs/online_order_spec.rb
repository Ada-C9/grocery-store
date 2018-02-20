require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

describe "OnlineOrder" do
  # Arrange
  id = 1
  products = {
    "Lobster" => 17.18,
    "Annatto seed" => 58.38,
    "Camomile" => 83.21
  }
  customer_id = 25
  status = "complete"
  initialize_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

  describe "#initialize" do
    it "Is a kind of Order" do
      # Assertion
      initialize_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # Action
      result = initialize_order.customer_id
      # Assertion
      result.must_equal customer_id
    end

    it "Can access the online order status" do
      # Action
      result = initialize_order.status
      # Assertion
      result.must_equal status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # Arrange
      total = 180.68
      # Action
      result = initialize_order.total
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
      result = initialize_order.add_product("banana", 7.55)
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
      customer_id_first = 25
      status = "complete"

      online_orders.first.id.must_equal id
      online_orders.first.products.must_equal products
      online_orders.first.customer_id.must_equal customer_id_first
      online_orders.first.status.must_equal status
    end

    it "Returns accurate information about the last online order" do
      id = 100
      products = {
        "Amaranth" => 83.81,
        "Smoked Trout" => 70.6,
        "Cheddar" => 5.63
      }
      customer_id_last = 20
      status_test = "pending"

      online_orders.last.id.must_equal id
      online_orders.last.products.must_equal products
      online_orders.last.customer_id.must_equal customer_id_last
      online_orders.last.status.must_equal status_test
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      order_25 = 25
      found_order = Grocery::OnlineOrder.find(25)
      found_order.id.must_equal order_25
    end

    it "Raises an error for an online order that doesn't exist" do
      order_125 = 125
      found_order = Grocery::OnlineOrder.find(125)
      found_order.must_equal ArgumentError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      customer_id_find = 15
      found_orders = Grocery::OnlineOrder.find_by_customer(15)
      found_orders.class.must_equal Array
    end

    it "Raises an error if the customer does not exist" do
      nonexisted_id = 125
      found_orders = Grocery::OnlineOrder.find_by_customer(125)
      found_orders.must_equal ArgumentError
    end

    it "Returns an empty array if the customer has no orders" do
    # In the online_order.csv, there is no empty order for any customer_id.
    # There is no empty test.
    end
  end
end
