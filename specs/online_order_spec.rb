require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.



#_______________ WAVE 3 _______________


describe "OnlineOrder" do

  #############################################################################################
  # INITIALIZES OnlineOrder:

  describe "#initialize" do
    it "Is a kind of Order" do
      id = 1337
      customer_id = 25
      products = {}
      # Check that an OnlineOrder is in fact a kind of Order
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status = :pending)
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = 1337
      customer_id = 25
      products = {}
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status = :pending)

      online_order.must_respond_to :customer_id
      online_order.customer_id.must_equal customer_id
      online_order.customer_id.must_be_kind_of Integer
    end

    it "Can access the online order status" do
      id = 1337
      customer_id = 25
      products = {}
      online_order = Grocery::OnlineOrder.new(id, products, customer_id, status = :pending)
      online_order.must_respond_to :products
      online_order.products.length.must_equal 0
    end
  end

  #############################################################################################
  # ADDS SHIPPING FEE TO TOTAL OF ORDER:

  describe "#total" do
    it "Adds a shipping fee" do

      online_order = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}, 25, "complete")

      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      sum = products.values.inject(0, :+)
      order_total = (sum + (sum * 0.075)).round(2)

      expected_total = order_total + 10

      online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do

      online_order = Grocery::OnlineOrder.new(nil, nil, nil)

      online_order.total.must_equal nil

    end
  end

  #############################################################################################
  # ADDS PRODUCT TO ORDER:

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do

      products = {"Lobster" => 17.18, "Annatto seed" => 58.38}
      online_order_processing = Grocery::OnlineOrder.new(4, products, nil, :processing)
      online_order_shipped = Grocery::OnlineOrder.new(4, products, nil, :shipped)
      online_order_complete = Grocery::OnlineOrder.new(4, products, nil, :complete)

      proc {online_order_processing.add_product("Camomile", 83.21)}.must_raise ArgumentError
      proc {online_order_shipped.add_product("Camomile", 83.21)}.must_raise ArgumentError
      proc {online_order_complete.add_product("Camomile", 83.21)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do

      # "Is added to the collection of products" & "Returns true if the product is new":

      products = {"Lobster" => 17.18, "Annatto seed" => 58.38}

        # Pending status:
      online_order_pending = Grocery::OnlineOrder.new(1, products, nil, :pending)
      online_order_pending.add_product("Camomile", 4.25)
      online_order_pending.products.include?("Camomile").must_equal true

      # Paid status:
      online_order_paid = Grocery::OnlineOrder.new(1, products, nil, :paid)
      online_order_paid.add_product("Camomile", 4.25)
      online_order_paid.products.include?("Camomile").must_equal true

    end
  end

  #############################################################################################
  # READS FILE OF ALL ORDERS AND ADDS THEM:

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
    end
  end

  #############################################################################################
  # FINDS ORDER:

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
