require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'

require_relative '../lib/order'
require_relative '../lib/online_order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  let(:all) {Grocery::OnlineOrder.all}
  let(:find_extra) {Grocery::OnlineOrder.find(150)}

  id = 7
  let(:products) {{"Rice"=>40.4567, "Meat"=>23.348}}
  customer = Grocery::Customer.new(20, "jerry@ferry.com", "90842 Amani Common, Weissnatfurt, TX, 24108")
  status = :complete
  let(:online_order) { Grocery::OnlineOrder.new(id, products, customer, status) }

  let(:first_online_order) {Grocery::OnlineOrder.new(1, {"Lobster"=>17.18, "Annatto seed"=>58.38,"Camomile"=>83.21}, Grocery::Customer.new(25, "summer@casper.io", "66255 D'Amore Parkway, New Garettport, MO, 57138"), :complete)}

  let(:last_online_order) {Grocery::OnlineOrder.new(100, {"Amaranth"=>83.81, "Smoked Trout"=>70.6,"Cheddar"=>5.63}, Grocery::Customer.new(20, "jerry@ferry.com", "90842 Amani Common, Weissnatfurt, TX, 24108"
  ), :pending)}

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      online_order.must_respond_to :customer
      online_order.customer.must_be_instance_of Grocery::Customer
      online_order.customer.id.must_equal 20
    end

    it "Can access the online order status" do
      online_order_without_staus = Grocery::OnlineOrder.new(100, {"Amaranth"=>83.81}, Grocery::Customer.new(20, "jerry@ferry.com", "90842 Amani Common, Weissnatfurt, TX, 24108"
      ))
      online_order.must_respond_to :status
      online_order.status.must_be_instance_of Symbol
      online_order.status.must_equal :complete
      online_order_without_staus.status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      sum  = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075) + 10

      online_order.total.must_be_instance_of Float
      online_order.total.must_be_within_delta expected_total, 0.01
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order_zero_product = Grocery::OnlineOrder.new(100, {}, Grocery::Customer.new(20, "jerry@ferry.com", "90842 Amani Common, Weissnatfurt, TX, 24108"
      ), :pending)
      online_order_zero_product.total.must_equal 0
    end
  end

  describe "#add_product" do
    online_order_shipped = Grocery::OnlineOrder.new(1, {"Lobster"=>17.18, "Annatto seed"=>58.38,"Camomile"=>83.21}, Grocery::Customer.new(25, "summer@casper.io", "66255 D'Amore Parkway, New Garettport, MO, 57138"), :shipped)

    it "Does not permit action for processing, shipped or completed statuses" do
      proc {online_order_shipped.add_product("Rice", 67.35)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      online_order_pending = Grocery::OnlineOrder.new(100, {"Amaranth"=>83.81, "Smoked Trout"=>70.6,"Cheddar"=>5.63}, Grocery::Customer.new(20, "jerry@ferry.com", "90842 Amani Common, Weissnatfurt, TX, 24108"
      ), :pending)

      online_order_pending.must_respond_to :add_product
      online_order_pending.add_product("Rice", 67.35).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      all.must_be_instance_of Array
      all.length.must_equal 100
      all.each { |online_order| online_order.must_be_instance_of Grocery::OnlineOrder }
    end

    it "Returns accurate information about the first online order" do
      all[0].id.must_equal 1
      all[0].products[name].must_equal first_online_order.products[name]
      all[0].customer.id.must_equal first_online_order.customer.id
      all[0].status.must_equal first_online_order.status
    end

    it "Returns accurate information about the last online order" do
      all[-1].id.must_equal 100
      all[-1].products[name].must_equal last_online_order.products[name]
      all[-1].customer.id.must_equal last_online_order.customer.id
      all[-1].status.must_equal last_online_order.status
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      Grocery::OnlineOrder.find(1).must_be_instance_of Grocery::OnlineOrder
      Grocery::OnlineOrder.find(1).id.must_equal first_online_order.id
      Grocery::OnlineOrder.find(1).products[name].must_equal first_online_order.products[name]
      Grocery::OnlineOrder.find(1).status.must_equal first_online_order.status
      Grocery::OnlineOrder.find(100).id.must_equal last_online_order.id
      Grocery::OnlineOrder.find(100).products[name].must_equal last_online_order.products[name]
      Grocery::OnlineOrder.find(100).status.must_equal last_online_order.status
    end

    it "Returns nil for an order that doesn't exist" do
      find_extra.must_be_nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.find_by_customer(25).must_be_instance_of Array
      Grocery::OnlineOrder.find_by_customer(25).length.must_equal 6
      Grocery::OnlineOrder.find_by_customer(19).must_be_instance_of Array
      Grocery::OnlineOrder.find_by_customer(19).length.must_equal 3

    end

    it "Raises an error if the customer does not exist" do
      proc { Grocery::OnlineOrder.find_by_customer(40) }.must_raise ArgumentError

    end

    it "Returns an empty array if the customer has no orders" do
      # Customer 22 doesn't have any online order
      Grocery::OnlineOrder.find_by_customer(22).must_be_empty

    end
  end
end
