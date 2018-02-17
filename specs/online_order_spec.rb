require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

Minitest::Reporters.use!

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      id = 1234
      products = {}
      customer_id = 10
      status = :pending
      # Instatiate your OnlineOrder here
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.must_be_kind_of Grocery::Order
      online_order.class.must_equal Grocery::OnlineOrder
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      id = 1234
      products = {}
      customer_id = 10
      status = :pending

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      customer = online_order.customer

      online_order.must_respond_to :customer
      customer.class.must_equal Grocery::Customer
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      id = 1234
      products = {}
      customer_id = 10
      status = :pending

      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      order_status = online_order.status

      online_order.must_respond_to :status
      order_status.class.must_equal Symbol
      order_status.must_equal :pending
    end

    it "gives @status a value of :pending if no status is provided" do
      id = 1234
      products = {}
      customer_id = 10

      online_order = Grocery::OnlineOrder.new(id, products, customer_id)
      order_status = online_order.status

      online_order.must_respond_to :status
      order_status.class.must_equal Symbol
      order_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1234, products, 10, :complete)

      total = online_order.total
      expected_total = (( 1.99 + 3.00 ) + (( 1.99 + 3.00 )* 0.075 ) + 10 ).round(2)

      total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      products = {}
      online_order = Grocery::OnlineOrder.new(1234, products, 10, :complete)

      total = online_order.total

      total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order_1 = Grocery::OnlineOrder.new(1234, products, 10, :complete)
      online_order_2 = Grocery::OnlineOrder.new(1234, products, 10, :processing)
      online_order_3 = Grocery::OnlineOrder.new(1234, products, 10, :shipped)

      no_action_1 = online_order_1.add_product("sandwich", 2.34)
      no_action_2 = online_order_2.add_product("sandwich", 2.34)
      no_action_3 = online_order_3.add_product("sandwich", 2.34)

      no_action_1.must_be_nil
      no_action_2.must_be_nil
      no_action_3.must_be_nil
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order_1 = Grocery::OnlineOrder.new(1234, products, 10, :pending)
      online_order_2 = Grocery::OnlineOrder.new(1234, products, 10, :paid)

      some_action_1 = online_order_1.add_product("sandwich", 2.34)
      some_action_1 = online_order_2.add_product("sandwich", 2.34)

      online_order_1.products.include?("sandwich").must_equal true
      online_order_2.products.include?("sandwich").must_equal true
    end
  end

  xdescribe "OnlineOrder.all" do
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

  xdescribe "OnlineOrder.find" do
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
