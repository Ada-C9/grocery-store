require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/skip_dsl'

require_relative '../lib/customer'
require_relative '../lib/order'
require_relative '../lib/online_order'

describe "OnlineOrder" do
    customer_id = 42
    email = "adalovelace.gmail.com"
    address = {street: "42 Baker Street", city: "Seattle", state: "WA",
      zip_code: "98101-1820"}

    test_customer = Grocery::Customer.new(customer_id, email, address)

    test_order_id = 121
    test_order_products = {"banana" => 1.99, "cracker" => 3.00}

    test_online_order = Grocery::OnlineOrder.new(test_order_id,
      test_order_products, test_customer, :pending)



  describe "#initialize" do
    it "Is a kind of Order" do
      test_online_order.must_be_kind_of Grocery::Order

    end

    it "Can access Customer object" do
      test_online_order.customer.must_be_kind_of Grocery::Customer
      test_online_order.customer.must_equal test_customer
    end

    it "Can access the online order status" do
      test_online_order.fulfillment_status.must_be_kind_of Symbol
      test_online_order.fulfillment_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      test_online_order = Grocery::OnlineOrder.new(test_order_id,
        test_order_products, test_customer, :pending)
        expected_total = ((1.99 + 3.0) + ((1.99 + 3.0) * 0.075)).round(2) + 10.0

      test_online_order.total.must_be_kind_of Float
      test_online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      test_online_order = Grocery::OnlineOrder.new(test_order_id,
        {}, test_customer, :pending)
        test_online_order.total.must_be_kind_of Float
        test_online_order.total.must_equal 0.0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
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
