require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

# TODO: uncomment the next line once you start wave 3


# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      result = Grocery::OnlineOrder.all[0]
      result.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = Grocery::OnlineOrder.all[0].customer

      result = Grocery::Customer.find(id)

      result.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      result = Grocery::OnlineOrder.all[0].status

      result.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
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
