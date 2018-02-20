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
  xdescribe "#initialize" do
    before do
      online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
    it "Is a kind of Order" do
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
        online_order.customer_id.must_equal "25"
    end

    it "Can access the online order status" do
        online_order.status.must_equal "complete"
    end
  end

  xdescribe "#total" do
    it "Adds a shipping fee" do
      online_order = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
        "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
      #Option 1:
      sum = products.values.reduce(:+)
      tax = (sum * 0.075).round(2)
      expected_total = sum + tax + 10
      (online_order.total, expected_total).must_be_within_delta 0.02
      #Option 2:  (por que no los dos)
      (online_order.total, 180.68).must_be_within_delta 0.02
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new("1", {}, "25", "complete")
      online_order.total.must_equal 0
    end
  end

  xdescribe "#add_product" do
    before do
      online_order_1 = Grocery::OnlineOrder.new("34",{"Brown Flour" => 16.12, "Choy Sum" => 87.67}, "7", "processing")
      online_order_2 = Grocery::OnlineOrder.new("27",{"Apples" => 61.87, "Garlic" => 64.36} "27", "shipped")
      online_order_3 = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
      online_order_4 = Grocery::OnlineOrder.new("15",{"Cranberry" => 85.36} "8", "pending")
      online_order_5 = Grocery::OnlineOrder.new("39",{"Beans" => 78.89, "Mangosteens" => 35.01}, "31", "paid")



    it "Does not permit action for processing, shipped or completed statuses" do
        online_order_1.add_product("albatross", 12.50)
        online_order_2.add_product("Tide Pods", 6.50)
        online_order_3.add_product("Toe of Frog", 22.50)
        online_order_1.products.count.must_equal 3
        online_order_2.products.count.must_equal 2
        online_order_3.products.count.must_equal 3
    end


    it "Permits action for pending and paid statuses" do
      online_order_4.add_product("vegan ferret", 9.50)
      online_order_5.add_product("alfalfa smoothie", 5.50)
      online_order_4.products.count.must_equal 2
      online_order_5.products.count.must_equal 3
    end
  end
=b

  xdescribe "OnlineOrder.all" do
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
      Grocery::OnlineOrder.last.id.must_equal "100"

      Grocery::OnlineOrder.all.last.products.must_include("Amaranth")
      Grocery::OnlineOrder.all.last.products.must_include("Smoked Trout")
      Grocery::OnlineOrder.all.last.products.must_include("Cheddar")

      Grocery::OnlineOrder.last.products.count.must_equal Q

      sum_of_values = Grocery::OnlineOrder.last.products.values.reduce(:+)
      sum_of_values.must_be_within_delta 160.04, 0.001

      Grocery::OnlineOrder.all[0].customer_id.must_equal "20"
      Grocery::OnlineOrder.all[0].status.must_equal "pending"
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

  xdescribe "OnlineOrder.find_by_customer" do
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
