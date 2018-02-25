require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'

Minitest::Reporters.use!



describe "OnlineOrder" do
  describe "#initialize" do
    before do
      @online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
    end

    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access the order id" do
      @online_order.id.must_equal "1"
    end

    it "Can access Customer object" do
      @online_order.customer_id.must_equal "25"
    end

    it "Can access the online order status" do
      @online_order.status.must_equal "complete"
    end
  end


  describe "#total" do
    it "Adds a shipping fee" do
      online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
      #Option 1:
      sum = online_order.products.values.reduce(:+)
      tax = (sum * 0.075).round(2)
      expected_total = sum + tax + 10
      online_order.total.must_be_within_delta expected_total, 0.02
      online_order.total.must_be_within_delta 180.68, 0.02
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new("1", {}, "25", "complete")
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do

    it "Does not permit action for processing, shipped or completed statuses" do

      online_order_processing = Grocery::OnlineOrder.new("34",{"Brown Flour" => 16.12, "Choy Sum" => 87.67}, "7", "processing")
      online_order_processing.add_product("albatross", 12.50)
      online_order_processing.products.count.must_equal 2
      online_order_processing.products.wont_include "albatross"

      online_order_shipped = Grocery::OnlineOrder.new("27",{"Apples" => 61.87, "Garlic" => 64.36}, "27", "shipped")
      online_order_shipped.add_product("Tide Pods", 6.50)
      online_order_shipped.products.count.must_equal 2
      online_order_shipped.products.wont_include "Tide Pods"

      online_order_complete = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
      online_order_complete.add_product("Toe of Frog", 22.50)
      online_order_complete.products.count.must_equal 3
      online_order_complete.products.wont_include "Toe of Frog"
    end


    it "Permits action for pending and paid statuses" do

      online_order_pending = Grocery::OnlineOrder.new("15",{"Cranberry" => 85.36}, "8", "pending")
      online_order_pending.add_product("vegan ferret", 9.50)
      online_order_pending.products.count.must_equal 2
      online_order_pending.products.must_include "vegan ferret"


      online_order_paid = Grocery::OnlineOrder.new("39",{"Beans" => 78.89, "Mangosteens" => 35.01}, "31", "paid")
      online_order_paid.add_product("lugnuts", 5.50)
      online_order_paid.products.count.must_equal 3
      online_order_paid.products.must_include "lugnuts"
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
      Grocery::OnlineOrder.all.each do |element|
        element.must_be_instance_of Grocery::OnlineOrder
      end
      Grocery::OnlineOrder.all.count.must_equal 100
    end

    it "Returns accurate information about the first online order" do

      Grocery::OnlineOrder.all[0].id.must_equal "1"

      Grocery::OnlineOrder.all[0].products.must_include("Lobster")
      Grocery::OnlineOrder.all[0].products.must_include("Annatto seed")
      Grocery::OnlineOrder.all[0].products.must_include("Camomile")

      Grocery::OnlineOrder.all[0].products.count.must_equal 3

      sum_of_values = Grocery::OnlineOrder.all[0].products.values.reduce(:+)
      sum_of_values.must_be_within_delta 158.77, 0.001

      Grocery::OnlineOrder.all[0].customer_id.must_equal "25"
      Grocery::OnlineOrder.all[0].status.must_equal "complete"

    end

    it "Returns accurate information about the last online order" do

      Grocery::OnlineOrder.all.last.id.must_equal "100"

      Grocery::OnlineOrder.all.last.products.must_include("Amaranth")
      Grocery::OnlineOrder.all.last.products.must_include("Smoked Trout")
      Grocery::OnlineOrder.all.last.products.must_include("Cheddar")

      Grocery::OnlineOrder.all.last.products.count.must_equal 3

      sum_of_values = Grocery::OnlineOrder.all.last.products.values.reduce(:+)
      sum_of_values.must_be_within_delta 160.04, 0.001

      Grocery::OnlineOrder.all.last.customer_id.must_equal "20"
      Grocery::OnlineOrder.all.last.status.must_equal "pending"
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      Grocery::OnlineOrder.find("1").products.must_include("Lobster")
    end

    it "Raises an error for an online order that doesn't exist" do
      assert_raises ArgumentError do
        Grocery::OnlineOrder.find("102")
      end
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

      Grocery::OnlineOrder.find_by_customer("10").must_be_kind_of Array

      Grocery::OnlineOrder.find_by_customer("10").count.must_equal 4

      found_order_array = Grocery::OnlineOrder.find_by_customer("10")
      ids_of_found_orders = []
      found_order_array.each do |order_instance|
        found_id = order_instance.id
        ids_of_found_orders << found_id
      end

      ids_of_found_orders.must_include "2"
      ids_of_found_orders.must_include "16"
      ids_of_found_orders.must_include "61"
      ids_of_found_orders.must_include "88"
    end

    it "Returns an empty array if the customer does not exist" do
      Grocery::OnlineOrder.find_by_customer("110").must_be_kind_of Array
      Grocery::OnlineOrder.find_by_customer("110").must_be_empty
    end

    it "Returns an empty array if the customer has no orders" do
      Grocery::OnlineOrder.find_by_customer("22").must_be_kind_of Array
      Grocery::OnlineOrder.find_by_customer("22").must_be_empty
    end
  end
end
