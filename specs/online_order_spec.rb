require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do

      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      sum = products.values.inject(0, :+)
      cents_total_fee = (sum + (sum * 0.075))*100.round + 1000

      total_with_money = online_order.total
      total_with_money.must_equal Money.new(cents_total_fee, "USD")
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      total_with_money = online_order.total
      total_with_money.must_equal Money.new(0, "USD")
    end
  end

  describe "#add_product" do
    it "Permits action for pending and paid satuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      status = [:pending, :paid]
      status.each do |status|
        online_order = Grocery::OnlineOrder.new(1325, products, customer, status)
        online_order.add_product("salad", 4.25).wont_be_nil
      end
    end

    it "Does not permit action for processing, shipped or completed statuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      status = [:processing, :shipped, :complete]
      status.each do |status|
        online_order = Grocery::OnlineOrder.new(1325, products, customer, status)
        online_order.add_product("salad", 4.25).must_raise StandardError
      end
    end

  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      online_orders_entered = Grocery::OnlineOrder.all

      online_orders_entered.class.must_equal Array

      count = 0
      online_orders_entered.each do |order|
        count += 1
      end
      count.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      online_orders_entered = Grocery::OnlineOrder.all
      first_order = online_orders_entered[0]

      first_order.id.must_equal 1
      first_order.products.must_equal({"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21})
      first_order.customer.id.must_equal 25
      first_order.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      online_orders_entered = Grocery::OnlineOrder.all
      first_order = online_orders_entered[-1]

      first_order.id.must_equal 100
      first_order.products.must_equal({"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63})
      first_order.customer.id.must_equal 20
      first_order.status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      specific_order = Grocery::OnlineOrder.find(5)

      specific_order.id.must_equal 5
      specific_order.products.must_equal({"Sour Dough Bread"=>35.11})
      specific_order.customer.id.must_equal 21
      specific_order.status.must_equal :shipped
    end

    it "Raises an error for an online order that doesn't exist" do
      fake_order = Grocery::OnlineOrder.find(500)

      fake_order.must_raise StandardError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      customers_online_orders = Grocery::OnlineOrder.find_by_customer(15)

      customers_online_orders.length.must_equal 3
      customers_online_orders.class.must_equal Array
    end

    it "Raises an error if the customer does not exist" do
      customers_online_orders = Grocery::OnlineOrder.find_by_customer(150)

      customers_online_orders.must_raise StandardError
    end

    it "Returns an empty array if the customer has no orders" do
      customers_online_orders = Grocery::OnlineOrder.find_by_customer(22)

      customers_online_orders.must_be_empty
    end

  end
end
