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
      # Instatiate your GroceryOnlineOrder here
      online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
      # online_order =
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")

        online_order.customer_id.must_equal "25"
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")

        online_order.status.must_equal "complete"
    end
  end

  xdescribe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  xdescribe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
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

    it "Returns an empty array if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
