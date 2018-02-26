require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# require_relative 'order.rb'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do

  describe "#initialize" do

    before do
      @online_order = Grocery::OnlineOrder.new(4, {"Aubergine" => 56.71, "Brown rice vinegar" => 33.52, "dried Chinese Broccoli" => 51.74}, 35, "paid")
    end

    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      @online_order.must_be_kind_of Grocery::Order
    end

    xit "Can access Customer object" do
      # TODO: Your test code here!
    end

    it "Can access the online order status" do
      @online_order.status.must_equal "paid"
    end
  end

  describe "#total" do

    before do
      @online_order = Grocery::OnlineOrder.new(4, {"Aubergine" => 56.71, "Brown rice vinegar" => 33.52, "dried Chinese Broccoli" => 51.74}, 35, "paid")
    end

    it "Adds a shipping fee" do
      @online_order.total.must_equal 162.62
    end

    it "Doesn't add a shipping fee if there are no products" do
      empty_online_order = Grocery::OnlineOrder.new(4, {}, 35, "paid")
      empty_online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      shipped_online_order = Grocery::OnlineOrder.new(5,{"Sour Dough Bread" => 35.11}, 21, "shipped")
      proc { shipped_online_order.add_product("bananas", 1.99) }.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      another_order = Grocery::OnlineOrder.new(36, {"Oranges" => 12.05, "Tomatoes" => 28.46, "Mahi mahi" => 67.78}, 20, :pending)
      another_order.add_product("bananas", 1.99).must_equal true
      proc { another_order.add_product("bananas", 1.99) }.must_be_silent
    end
  end

  describe "OnlineOrder.all" do

    before do
      @@all_online_orders = Grocery::OnlineOrder.all
    end

    it "Returns an array of all online orders" do
      @@all_online_orders.length.must_equal 100
      @@all_online_orders.must_be_kind_of Array
    end

    it "Returns accurate information about the first online order" do
      first_row_online_products = {"Lobster" => "17.18", "Annatto seed" => "58.38", "Camomile" => "83.21"}
      order = Grocery::OnlineOrder.all.first

      order.id.must_equal 1
      order.products.must_equal first_row_online_products
      order.customer_id.must_equal 25
      order.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      last_row_online_products = {"Amaranth" => "83.81", "Smoked Trout" => "70.6", "Cheddar" => "5.63"}

      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.products.must_equal last_row_online_products
      Grocery::OnlineOrder.all.last.customer_id.must_equal 20
      Grocery::OnlineOrder.all.last.status.must_equal :pending    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      first_order = Grocery::OnlineOrder.find(1)
      first_order[0].must_be_instance_of Grocery::Order
    end

    it "Return nil for an online order that doesn't exist" do
      rand_order_num = Grocery::OnlineOrder.find(299)
      rand_order_blank = Grocery::OnlineOrder.find ()
      rand_order_neg = Grocery::OnlineOrder.find(-32)

      rand_order_num.must_be_nil
      rand_order_blank.must_be_nil
      rand_order_neg.must_be_nil    end
  end

  describe "OnlineOrder.find_by_customer" do
    xit "Returns an array of online orders for a specific customer ID" do
      rand_order = Grocery::OnlineOrder.find_by_customer(25)

      rand_order.must_be_kind_of Array
    end

    xit "Returns an empty array if the customer does not exist" do
      rand_order = Grocery::OnlineOrder.find_by_customer(145)

      rand_order.must_be_nil
    end

    xit "Returns an empty array if the customer has no orders" do
      # customers that have no orders are 16 & 22
      rand_order_16 = Grocery::OnlineOrder.find_by_customer(16)
      rand_order_22 = Grocery::OnlineOrder.find_by_customer(22)

      rand_order_16.must_be_nil
      rand_order_22.must_be_nil
    end
  end
end
