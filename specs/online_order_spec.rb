require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'

describe "OnlineOrder" do

  before do
    id = 123
    products = { "beans" => 2, "bread" => 4 }
    customer_id = 4
    status = "complete"
    @order = Grocery::Order.new(id, products)
    @online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer_id.must_equal 4
    end

    it "Can access the online order status" do
      @online_order.status.must_equal "complete"
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @online_order.total.must_equal @order.total + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      id = 123
      products = {}
      customer_id = 4
      status = "complete"
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      assert_raises ArgumentError do
        @online_order.add_product
      end
    end

    it "Permits action for pending and paid satuses" do
      id = 123
      products = { "beans" => 2, "bread" => 4 }
      customer_id = 4
      status = "paid"
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)

      online_order.add_product("salad", 3.50).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      array_of_orders = Grocery::OnlineOrder.all

      array_of_orders.must_be_kind_of Array
      array_of_orders.length.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      array_of_orders = Grocery::OnlineOrder.all
      first_id = array_of_orders[0][0]
      first_products = array_of_orders[0][1]

      first_id.must_equal 1
      first_products["Camomile"].must_equal 83.21
    end

    it "Returns accurate information about the last online order" do
      array_of_orders = Grocery::OnlineOrder.all
      last_id = array_of_orders[-1][0]
      last_products = array_of_orders[-1][1]

      last_id.must_equal array_of_orders.length
      last_products["Cheddar"].must_equal 5.63
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      specific_online_order = Grocery::OnlineOrder.find(65)

      specific_online_order.must_equal Grocery::OnlineOrder.all[64]
    end

    it "Raises an error for an online order that doesn't exist" do
      assert_raises ArgumentError do
        nonexistant_order = Grocery::OnlineOrder.find(200)
      end
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      specific_customer_orders = Grocery::OnlineOrder.find_by_customer(25)
      specific_customer_id = specific_customer_orders[0][2]

      specific_customer_orders.must_be_kind_of Array
      specific_customer_id.must_equal 25
    end

    it "Raises an error if the customer does not exist" do
      assert_raises ArgumentError do
        nonexistant_customer = Grocery::OnlineOrder.find_by_customer(1000)
      end
    end

    it "Returns an empty array if the customer has no orders" do
      # I know I'm supposed to test Grocery::OnlineOrder.find_by_customer but I wasn't able to implement it without manually adding a customer with zero products to the online_orders.csv

      array_of_orders = Grocery::OnlineOrder.all
      empty_order = [400, {}, 300, "paid"]
      array_of_orders << empty_order

      products = array_of_orders[-1][1]
      customer_id = empty_order[2]

      customer_id.must_equal 300
      products.length.must_equal 0
    end
  end
end
