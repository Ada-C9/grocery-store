require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/onlineorder.rb'

Minitest::Reporters.use!

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      #Instatiate OnlineOrder
      products = { "banana chips" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(1337, products, 1235, :pending)

      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer ID" do
      # TODO: Your test code here!
      products = { "banana chips" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(1337, products, 1235, :pending)

      online_order.customer_id.must_equal 1235
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      products = { "banana chips" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(1337, products, 1235, :pending)

      online_order.fulfillment_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      products = { "banana chips" => 1.99, "cracker" => 3.00 }
      online_order = OnlineOrder.new(1337, products, 1235, :pending)

      online_order.total.must_equal 15.36
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      products = { }
      online_order = OnlineOrder.new(3337, products, 1235, :pending)

      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      online_order = OnlineOrder.new(1337, products, 3353, :shipped)

      online_order.add_product("salad", 4.25)
      expected_count = before_count
      online_order.products.count.must_equal expected_count
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      online_order = OnlineOrder.new(1337, products, 3353, :pending)

      online_order.add_product("salad", 4.25)
      expected_count = before_count + 1
      online_order.products.count.must_equal expected_count
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      arr_onlineorders = OnlineOrder.all

      arr_onlineorders.must_be_kind_of Array
      arr_onlineorders.length.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      arr_onlineorders = OnlineOrder.all

      arr_onlineorders[0].must_equal [1, {"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21}, 25, :complete]
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      arr_onlineorders = OnlineOrder.all

      arr_onlineorders[99].must_equal [100, {"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63}, 20, :pending]
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
        OnlineOrder.find(100).must_equal [100, {"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63}, 20, :pending]
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
      OnlineOrder.find(111).must_be_nil
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
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
