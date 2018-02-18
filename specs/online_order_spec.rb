require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.all[0]

      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # this part is optional as Customer class not required
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.all[0]

      online_order.order_status.must_equal "complete"
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::OnlineOrder.new(1, products, 13, "complete")

      sum = products.values.inject(0, :+)

      expected_total = sum + (sum * 0.075).round(2) + 10

      order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do

    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      first_order = Grocery::OnlineOrder.all[0]

      # complete status
      proc { first_order.add_product("salad", 4.25, "complete") }.must_raise ArgumentError

      # shipped status
      proc { first_order.add_product("salad", 4.25, "shipped") }.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order_1 = Grocery::OnlineOrder.new(1337, products, 2, "pending")

      order_2 = Grocery::OnlineOrder.new(1337, products, 2, "paid")

      order_1.add_product("lettuce", 2)

      order_2.add_product("pork_chops", 15)

      order_1.products.include?("lettuce").must_equal true

      order_2.products.include?("pork_chops").must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      all_online_orders = Grocery::OnlineOrder.all

      all_online_orders.must_be_kind_of Array

      all_online_orders[0].must_be_instance_of Grocery::OnlineOrder
    end

    it "Returns accurate information about the first online order" do
      online_orders = Grocery::OnlineOrder.all
      online_orders[0].order_id.must_equal 1
      online_orders[0].products.must_equal "Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21
      online_orders[0].customer_id.must_equal 25
      online_orders[0].order_status.must_equal "complete"
    end

    it "Returns accurate information about the last online order" do
      online_orders = Grocery::OnlineOrder.all
      online_orders[99].order_id.must_equal 100
      online_orders[99].products.must_equal "Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63
      online_orders[99].customer_id.must_equal 20
      online_orders[99].order_status.must_equal "pending"
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      expected_order = Grocery::OnlineOrder.all[0]
      first_order = Grocery::OnlineOrder.find(1)
      first_order.must_equal expected_order
    end

    it "Raises an error for an online order that doesn't exist" do
      search_nonexistent = Grocery::OnlineOrder.find(500)
      expected_message = "Error: Order ID does not exist"
      search_nonexistent.must_equal expected_message
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      found_customer_orders = Grocery::OnlineOrder.find_by_customer(25)

      found_customer_orders.must_be_kind_of Array

      found_customer_orders[0].must_be_instance_of Grocery::OnlineOrder
    end

    it "Raises an error if the customer does not exist" do
      search_nonexistent = Grocery::OnlineOrder.find_by_customer(300)
      expected_message = "Error: Order ID does not exist"
      search_nonexistent[0].must_equal expected_message
    end

    it "Returns an empty array if the customer has no orders" do
      search_nonexistent = Grocery::OnlineOrder.find_by_customer(300)
      empty_array = search_nonexistent[1]
      empty_array.must_be_kind_of Array
      empty_array.must_be_empty
    end
  end
end
