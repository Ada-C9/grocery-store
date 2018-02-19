require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/onlineorder'

Minitest::Reporters.use!
# You may also need to require other classes here
require_relative '../lib/order.rb'
# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @test_id = 123
    @products = {"apple" => 2.5}
    @test_email = "test@email.com"
    @test_address = "test address"
    @customer = Grocery::Customer.new(@test_id, @test_email, @test_address)
    @fulfillment_status = 'pending'
  end

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      online_order = OnlineOrder.new(@test_id, @products, @customer, @fulfillment_status)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      online_order = OnlineOrder.new(@test_id, @products, @customer, @fulfillment_status)

      customer_obj = online_order.customer
      customer_obj.id.must_equal 123
      customer_obj.email.must_equal "test@email.com"
      customer_obj.address.must_equal "test address"
      customer_obj.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      online_order = OnlineOrder.new(@test_id, @products, @customer, @fulfillment_status)

      online_order_status = online_order.fulfillment_status
      online_order_status.must_equal 'pending'
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      online_order = OnlineOrder.new(@test_id, @products, @customer, @fulfillment_status)
      total = online_order.total
      total.must_equal 12.69
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      online_order = OnlineOrder.new(@test_id, {}, @customer, @fulfillment_status)
      total = online_order.total
      total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      online_order = OnlineOrder.new(@test_id, @products, @customer, 'processing')
      assert_raises(ArgumentError) {online_order.add_product("banana", 1.25)}
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
      paid_online_order = OnlineOrder.new(@test_id, @products, @customer, 'paid')
      pending_online_order = OnlineOrder.new(@test_id, @products, @customer)
      paid_online_order.add_product("banana", 1.25).must_equal true
      pending_online_order.add_product("cookies", 1.5).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    before do
      @online_orders = OnlineOrder.all
    end
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      @online_orders.each do |order|
        order.must_be_kind_of OnlineOrder
      end
      @online_orders.length.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      first_order = @online_orders[0]
      first_order.id.must_equal 1
      first_order.products.must_equal ({"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21})
      first_order.customer.must_be_kind_of Grocery::Customer
      first_order.customer.id.must_equal 25
      first_order.customer.email.must_equal "summer@casper.io"
      first_order.customer.address.must_equal "66255 D'Amore Parkway, New Garettport, MO 57138"
      first_order.fulfillment_status.must_equal "complete"
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      last_order = @online_orders[99]
      last_order.id.must_equal 100
      last_order.products.must_equal ({"Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63})
      last_order.customer.must_be_kind_of Grocery::Customer
      last_order.customer.id.must_equal 20
      last_order.customer.email.must_equal "jerry@ferry.com"
      last_order.customer.address.must_equal "90842 Amani Common, Weissnatfurt, TX 24108"
      last_order.fulfillment_status.must_equal "pending"
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
      one_order = OnlineOrder.find(3)
      one_order.id.must_equal 3
      one_order.products.must_equal ({"Vegetable spaghetti" => 37.83, "Dates" => 90.88, "WhiteFlour" => 3.24, "Caraway Seed" => 54.29})
      one_order.customer.must_be_kind_of Grocery::Customer
      one_order.fulfillment_status.must_equal "processing"
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
      id = 200
      order = OnlineOrder.find(id)
      assert_nil(order, "There is no online order with that ID.")
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
      customer_id = 25
      customer_orders = OnlineOrder.find_by_customer(customer_id)
      customer_orders.must_be_kind_of Array
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
      customer_id = 40
      customer_orders = OnlineOrder.find_by_customer(customer_id)
      assert_nil(customer_orders, "ERROR: That customer does not exist.")
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
      customer_id = 16
      customer_orders = OnlineOrder.find_by_customer(customer_id)
      customer_orders.must_equal []
    end
  end
end
