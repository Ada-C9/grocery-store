require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'


# TODO: uncomment the next line once you start wave 3


describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      online_order = Grocery::Online_Orders.new(10, {}, 20,:paid)
      online_order.must_be_kind_of Grocery::Online_Orders
    end

    it "Can access Customer object" do
      #   # TODO: Your test code here!
      id = 6
      products = { "peaches" => 46.34}
      customer_id = 14
      fullfillment_status = :pending

      online_order = Grocery::Online_Orders.new(id, products, customer_id, fullfillment_status)
      online_order.customer_id.must_equal 14

    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      id = 12
      products = { "peaches" => 46.34}
      customer_id = 1
      fullfillment_status = :pending

      online_order = Grocery::Online_Orders.new(id, products, customer_id, fullfillment_status)
      online_order.fullfillment_status.must_equal :pending
    end

  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      products = { "peaches" => 46.34 }
      order = Grocery::Online_Orders.new(6, products, 14, :pending)
      sum= products.values.inject(0, :+)
      shipping_fee = 10
      expected_total = sum + (sum * 0.075).round(2) + shipping_fee

      order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!

      order = Grocery::Online_Orders.new(6, {}, 14, :pending)
      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!

      online_order_shipped = Grocery::Online_Orders.new(27, {"Apples" => 61.87, "Garlic" => 64.36}, 27, :shipped)
      online_order_shipped.add_product("apple", 12.3).must_be_nil

      online_order_processing = Grocery::Online_Orders.new(16, {"Ricemilk" => 5.07}, 10, :processing)
      online_order_processing.add_product("apple", 12.3).must_be_nil

      online_order_complete = Grocery::Online_Orders.new(38, {"Kale" => 90.99, "Miso" => 90.2}, 2, :complete)
      online_order_complete.add_product("apple", 12.3).must_be_nil

    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      online_order_pending = Grocery::Online_Orders.new(6, {"Peaches" => 46.34}, 14, :pending)
      online_order_pending.must_respond_to(:add_product)
      online_order_pending.add_product("apple", 12.3).must_equal true

      online_order_paid = Grocery::Online_Orders.new(13, {"Lettuce" => 37.94, "Paper" => 23.93, "Flaxseed" => 23.67}, 19, :paid)
      online_order_paid.must_respond_to(:add_product)
      online_order_paid.add_product("apple", 12.3).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      array = Grocery::Online_Orders.all
      array.must_be_instance_of Array

      Grocery::Online_Orders.all.length.must_equal 100

    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      first_order = Grocery::Online_Orders.all[0]
      first_order.id.must_equal 1

      expected_products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      first_order.products.must_equal expected_products
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      last_order = Grocery::Online_Orders.all[-1]
      last_order.id.must_equal 100

      expected_products = {"Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63 }
      last_order.products.must_equal expected_products
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
      Grocery::Order.find(1).must_be_instance_of Grocery::Order
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
      result = Grocery::Order.find(110)
      result.must_be_nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      orders_per_customer = Grocery::Online_Orders.find_by_customer(10)
      orders_per_customer.must_be_instance_of Array

      # I counted manually how many orders customer of id #10 have and it was 4.
      Grocery::Online_Orders.find_by_customer(10).length.must_equal 4
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!

      # I tested with customer id's that don't exist
      Grocery::Online_Orders.find_by_customer(40).must_be_nil
      Grocery::Online_Orders.find_by_customer(0).must_be_nil
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!

# I look the online_orders.csv file and manually look for a customer id with no orders. And an example is customer id # 22
      Grocery::Online_Orders.find_by_customer(22).must_be_empty
    end
  end
end
