require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# require classes
require_relative '../lib/online_order'

require "csv"

require 'awesome_print'

Minitest::Reporters.use!

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # arrange
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = []
      status = "paid"
      # act
      # Instatiate your OnlineOrder here
      Grocery::Order.new(id, products)
      online_order = Grocery::OnlineOrder.new(id, products, customer, status)

      # assert
      # Check that an OnlineOrder is in fact a kind of Order
      online_order.must_be_kind_of Grocery::Order
    end

    it "Takes an ID, collection of products, customer, and status" do
      # arrange
      id = 1337
      products = {}
      customer = Grocery::Customer.find("1")
      # act
      Grocery::Order.new(id, products)
      online_order = Grocery::OnlineOrder.new(id, products, customer)
      # assert
      online_order.must_respond_to :id
      online_order.id.must_equal id
      online_order.id.must_be_kind_of Integer

      online_order.must_respond_to :products
      online_order.products.length.must_equal 0

      online_order.must_respond_to :customer
      online_order.customer.must_be_kind_of Grocery::Customer

      online_order.must_respond_to :status
      online_order.status.must_be_kind_of Symbol
      online_order.status.must_equal :pending
    end

    it "Can access Customer object" do
      # arrange
      id = 1337
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.find("1")
      status = "paid"
      # act
      Grocery::Order.new(id, products)
      online_order = Grocery::OnlineOrder.new(id, products, customer, status)
      # assert
      online_order.customer.must_be_kind_of Grocery::Customer
      online_order.customer.email.must_equal "leonard.rogahn@hagenes.org"
    end

    it "Can access the online order status" do
      # arrange
      # No arrage needed
      # act
      online_order = Grocery::OnlineOrder.all[0]
      # assert
      online_order.must_respond_to :status
      online_order.status.must_be_instance_of Symbol
      online_order.status.must_equal :complete
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # arrange
      # no arrange needed (pulling data from csv and other classes)
      # act
      Grocery::OnlineOrder.all
      # assert
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "Returns accurate information about the first online order" do
      # arrange
      # no arrange needed (pulling data from csv and other classes)
      # act
      Grocery::OnlineOrder.all
      # assert
      Grocery::OnlineOrder.all[0].id.must_equal "1"
      Grocery::OnlineOrder.all[0].status.must_equal :complete
      Grocery::OnlineOrder.all[0].customer.id.must_equal "25"
    end

    it "Returns accurate information about the last online order" do
      # arrange
      # no arrange needed (pulling data from csv and other classes)
      # act
      Grocery::OnlineOrder.all
      # assert
      Grocery::OnlineOrder.all[-1].id.must_equal "100"
      Grocery::OnlineOrder.all[-1].status.must_equal :pending
      Grocery::OnlineOrder.all[-1].customer.id.must_equal "20"
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # arrage
      # Done by csv
      # act
      first_order_products = Grocery::OnlineOrder.all[0].products
      sum = first_order_products.values.inject(0,:+)
      expected_total = (sum + (sum * 0.075)).round(2) + 10
      first_order = Grocery::OnlineOrder.all[0]
      # assert
      first_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      # arrange
      products = {}
      order = Grocery::OnlineOrder.new(1337, products, 1, :pending)
      # act
      # assert
      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # arrange
      # CSV data
      # act
      complete_online_order = Grocery::OnlineOrder.all[0]
      processing_online_order = Grocery::OnlineOrder.all[2]
      shipped_online_order = Grocery::OnlineOrder.all[4]

      # assert
      [complete_online_order, processing_online_order,shipped_online_order].each do |online_order|
        proc {online_order.add_product("marshmellows",2) }.must_raise ArgumentError
      end
    end

    it "Permits action for pending and paid satuses" do
      # arrange
      # act
      paid_online_order =  Grocery::OnlineOrder.all[1]
      pending_online_order = Grocery::OnlineOrder.all[5]

      paid_online_order.add_product("chocolate", 4)
      pending_online_order.add_product("wine", 8)
      
      # assert
      paid_online_order.products.keys.length.must_equal 5
      paid_online_order.products.keys.must_include "chocolate"
      pending_online_order.products.keys.length.must_equal 2
      pending_online_order.products.keys.must_include "wine"

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
