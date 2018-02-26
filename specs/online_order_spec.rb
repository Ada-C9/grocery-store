require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
    online_order = OnlineOrder.new(@id, {})

    online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
    end

    it "Can access the online order status" do
      online_order = OnlineOrder.new(@id, {})

      online_order.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      online_order = OnlineOrder.new(1337, products)

      add_price = products.values.inject(0, :+)

      total_with_shipping = (add_price + (add_price * 0.075).round(2) + 10)

      online_order.total.must_equal total_with_shipping
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}

      online_order = OnlineOrder.new(1, products)

      total_with_shipping = 0

      online_order.total.must_equal total_with_shipping


    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order_processing = OnlineOrder.new(200, products, :processino)
      order_shipped = OnlineOrder.new(201, products, :shipped)
      order_completed = OnlineOrder.new(202, products, :completed)

      order_processing.add_product("banana" => 1.99).must_raise ArgumentError
      order_shipped.add_product("banana" => 1.99).must_raise ArguementError
      order_completed.add_product("banana" => 1.99).must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
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
