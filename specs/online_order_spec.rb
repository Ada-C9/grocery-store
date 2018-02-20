require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require 'csv'

# Wave 3
# All stubbed tests are implemented fully and pass
# Used inheritance in the initialize for online order
# Used inheritance for the total method in online order
# Appropriately created Customer class and class methods
#   all & find
# Use CSV library only in OnlineOrder.all
# Used all to get order list in find
# Appropriately searches for Customer orders in find_by_customer


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
      # Instatiate your OnlineOrder here
      products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
      online_order = Grocery::OnlineOrder.new(1, products, 25, :complete)

      online_order.must_be_kind_of Grocery::OnlineOrder
    end

    xit "Can access Customer object" do
      # TODO: Your test code here!
    end

    it "Can access the online order status" do
      products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
      online_order = Grocery::OnlineOrder.new(1, products, 25, :complete)

      online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
      online_order = Grocery::OnlineOrder.new(1, products, 25, :complete)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2) + 10

      online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      online_order = Grocery::OnlineOrder.new(1, products, 25, :complete)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)

      online_order.total.must_be_kind_of NilClass
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
      online_order = Grocery::OnlineOrder.new(1, products, 25, :completed)

      proc { online_order.add_product }.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
      online_order = Grocery::OnlineOrder.new(1, products, 25, :pending)

      proc { online_order.add_product }.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      order = Grocery::OnlineOrder.all

      order.must_be_kind_of Array
    end

    it "Returns accurate information about the first online order" do
      order = Grocery::OnlineOrder.all

      order[0].must_be_kind_of Grocery::OnlineOrder
    end

    it "Returns accurate information about the last online order" do
      order = Grocery::OnlineOrder.all

      order[99].must_be_kind_of Grocery::OnlineOrder
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      find_id = Grocery::OnlineOrder.find(1)

      find_id.must_be_kind_of Grocery::OnlineOrder
    end

    it "Raises an error for an online order that doesn't exist" do
      find_id = Grocery::OnlineOrder.find(101)

      find_id.must_be_kind_of NilClass
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      customer_id = Grocery::OnlineOrder.find_by_customer(21)

      customer_id.must_be_kind_of Grocery::OnlineOrder
    end

    it "Raises an error if the customer does not exist" do
      customer_id = Grocery::OnlineOrder.find_by_customer(22)

      customer_id.must_be_kind_of NilClass
    end

    xit "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
