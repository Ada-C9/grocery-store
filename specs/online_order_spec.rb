require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :processing
      @online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
    end

    it "Is a kind of Order" do
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_kind_of Grocery::Customer
      @online_order.must_respond_to :customer
      @online_order.customer.id.must_equal 25
      @online_order.customer.email.must_equal "summer@casper.io"
      @online_order.customer.address.must_equal "66255 D'Amore Parkway"
      @online_order.customer.city.must_equal "New Garettport"
      @online_order.customer.state.must_equal "MO"
      @online_order.customer.zip.must_equal "57138"
    end

    it "Can access the online order status" do
      @online_order.must_respond_to :status
      @online_order.status.must_equal :processing
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :processing
      order = Grocery::Order.new(id, products)
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      before_shipping = order.total
      after_shipping = online_order.total
      (after_shipping - before_shipping).must_equal 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      id = 102
      products = {}
      customer_id = 25
      status = :processing
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing status" do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :processing
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      error = proc { online_order.add_product("tortillas", 2.25) }.must_raise ArgumentError
      error.message.must_match (/The order status is processing. New products can no longer be added to this order./)
    end

    it "Does not permit action for shipped status" do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :shipped
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      error = proc { online_order.add_product("tortillas", 2.25) }.must_raise ArgumentError
      error.message.must_match (/The order status is shipped. New products can no longer be added to this order./)
    end

    it "Does not permit action for shipped status" do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :complete
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      error = proc { online_order.add_product("tortillas", 2.25) }.must_raise ArgumentError
      error.message.must_match (/The order status is complete. New products can no longer be added to this order./)
    end

    it "Permits action for pending status" do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :pending
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.add_product("tortillas", 2.25).must_equal true
      online_order.products.keys.must_include "tortillas"
    end

    it "Permits action for paid status" do
      id = 102
      products = {"rice"=>10.01, "beans"=>5.50}
      customer_id = 25
      status = :paid
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status)
      online_order.add_product("tortillas", 2.25).must_equal true
      online_order.products.keys.must_include "tortillas"
    end
  end

  describe "OnlineOrder.all" do
    before do
      @online_orders = Grocery::OnlineOrder.all
    end

    it "Returns an array of all online orders" do
      @online_orders.must_be_kind_of Array
      @online_orders.length.must_equal 100
      @online_orders.each do |order|
        order.must_be_instance_of Grocery::OnlineOrder
      end
    end

    it "Returns accurate information about the first online order" do
      @online_orders.first.id.must_be_kind_of Integer
      @online_orders.first.id.must_equal 1
      @online_orders.first.products.must_be_kind_of Hash
      @online_orders.first.products.must_equal ({"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21})
      @online_orders.first.customer.must_be_kind_of Grocery::Customer
      @online_orders.first.customer.id.must_equal 25
      @online_orders.first.status.must_be_kind_of Symbol
      @online_orders.first.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      @online_orders.last.id.must_be_kind_of Integer
      @online_orders.last.id.must_equal 100
      @online_orders.last.products.must_be_kind_of Hash
      @online_orders.last.products.must_equal ({"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63})
      @online_orders.last.customer.must_be_kind_of Grocery::Customer
      @online_orders.last.customer.id.must_equal 20
      @online_orders.last.status.must_be_kind_of Symbol
      @online_orders.last.status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      order = Grocery::OnlineOrder.find(50)
      order.id.must_equal 50
      order.products.must_equal ({"Star Fruit"=>51.8})
      order.customer.id.must_equal 30
      order.status.must_equal :processing
    end

    it "Raises an error for an online order that doesn't exist" do
      error = proc { Grocery::OnlineOrder.find(1000) }.must_raise ArgumentError
      error.message.must_match (/Order 1000 could not be found in the online order database./)
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      orders = Grocery::OnlineOrder.find_by_customer(14)
      orders.must_be_kind_of Array
      orders.length.must_equal 3
      orders.each do |order|
        order.must_be_instance_of Grocery::OnlineOrder
        order.customer.id.must_equal 14
      end
    end

    it "Raises an error if the customer does not exist" do
      error = proc { Grocery::OnlineOrder.find_by_customer(1000) }.must_raise ArgumentError
      error.message.must_match (/Customer 1000 could not be found in the customer database./)
    end

    it "Returns an empty array if the customer has no orders" do
      orders = Grocery::OnlineOrder.find_by_customer(16)
      orders.must_be_kind_of Array
      orders.must_be_empty
    end
  end
end
