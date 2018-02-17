require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free!
# Here we'll only test things that are different.

describe "OnlineOrder" do

  products = {"apples": 3.24, "salad": 10.92, "crackers": 5.33}
  online_order = Grocery::OnlineOrder.new(12, products, 4, "pending")

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      online_order.must_be_kind_of Grocery::Order
    end

    xit "Can access Customer object" do
      id = online_order.customer_id
      customer = Grocery::OnlineOrder.find(id)
      customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      value = online_order.status
      value.must_equal :pending

    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      total = online_order.total
      sum = online_order.products.values.sum
      expected_total = (sum*1.075)+10
      total.must_equal expected_total.round(2)
    end

    it "Doesn't add a shipping fee if there are no products" do
      empty_order = Grocery::OnlineOrder.new(3,{},4,"pending")
      empty_order.total.must_equal 0
    end
  end

  describe "#add_product" do

    shipped_order = Grocery::OnlineOrder.new(3,products,3,"shipped")
    completed_order = Grocery::OnlineOrder.new(3,products,3,"completed")
    pending_order = Grocery::OnlineOrder.new(3,products,3,"pending")
    paid_order = Grocery::OnlineOrder.new(3,products,3,"paid")

    it "Does not permit action for processing, shipped or completed statuses" do
      value1 = shipped_order.add_product("oranges", 4.32)
      value2 = completed_order.add_product("oranges", 4.32)
      value1.must_equal

      value2.must_equal


    end

    it "Permits action for pending and paid satuses" do

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do

    end

    it "Returns accurate information about the first online order" do

    end

    it "Returns accurate information about the last online order" do

    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do

    end

    it "Raises an error for an online order that doesn't exist" do

    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

    end

    it "Raises an error if the customer does not exist" do

    end

    it "Returns an empty array if the customer has no orders" do

    end
  end
end
