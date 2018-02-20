require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'


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

      # Evaluate:
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
      # Evaluate:
      online_order_pending.products.include?("Camomile").must_equal true

      # Paid status:
      online_order_paid = Grocery::OnlineOrder.new(1, products, nil, :paid)
      online_order_paid.add_product("Camomile", 4.25)
      # Evaluate:
      online_order_paid.products.include?("Camomile").must_equal true

    end
  end

  #############################################################################################
  # READS FILE OF ALL ORDERS AND ADDS THEM:

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      online_orders = CSV.read('support/online_orders.csv', 'r')

      Grocery::OnlineOrder.all.length.must_equal online_orders.length

      Grocery::OnlineOrder.all.must_be_kind_of Array
    end


    it "Returns accurate information about the first online order" do
      file_last_order = Grocery::OnlineOrder.new(1, {"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21}, 25, "complete")

      # create array of the first_order:
      last_order = Grocery::OnlineOrder.all[0]

      # evaluate:
      file_last_order.id.must_equal last_order.id
      file_last_order.products.must_equal last_order.products
      file_last_order.customer_id.must_equal last_order.customer_id
      file_last_order.status.must_equal last_order.status

    end


    it "Returns accurate information about the last online order" do
      # Create order #1:
    file_last_order = Grocery::OnlineOrder.new(100, {"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63}, 20, "pending")

    # create array of the first_order:
    last_order = Grocery::OnlineOrder.all[99]

    # evaluate:
    file_last_order.id.must_equal last_order.id.to_i
    file_last_order.products.must_equal last_order.products
    file_last_order.customer_id.must_equal last_order.customer_id
    file_last_order.status.must_equal last_order.status
    end
  end

  #############################################################################################
  # FINDS ORDER BY ID:

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # Order #1 on file:
      #(Order number:)
      online_first_order_number = CSV.read('support/online_orders.csv', 'r')[0][0].to_i
      #(Order status:)
      online_first_order_status = CSV.read('support/online_orders.csv', 'r')[0][3]


      # Create all orders on Grocery module and search for the order #1:
      online_order = Grocery::OnlineOrder.all
      find_id = Grocery::OnlineOrder.find(1)

      # Evaluate:
      online_first_order_number.must_equal find_id.id #(Order number:)
      online_first_order_status.must_equal find_id.status #(Order status:)
    end

    it "Raises an error for an online order that doesn't exist" do
      # Order that doesnt exists on file:
      error = "Order doesn't exist!"
      # Create all orders on Grocery module and search for the order #101 - doesnt exist!:
      Grocery::OnlineOrder.all
      find =  Grocery::OnlineOrder.find(101)

      error.must_equal find
    end
  end


  #############################################################################################
  # FINDS ORDER BY COSTUMER_ID:

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

      online_orders = CSV.read('support/online_orders.csv', 'r')
      Grocery::OnlineOrder.all
      Grocery::OnlineOrder.find_by_customer(1).must_be_kind_of Array

    end

    it "Raises an error if the customer does not exist" do

      online_orders = CSV.read('support/online_orders.csv', 'r')
      Grocery::OnlineOrder.all
      # Grocery::OnlineOrder.find_by_customer(50).must_equal "Costumer doesn't exist or has no orders!"
      Grocery::OnlineOrder.find_by_customer(50).size.must_equal 0

    end

    it "Returns an empty array if the customer has no orders" do
      #Costumer #16 does not have orders on the CSV file.

      online_orders_found = Grocery::OnlineOrder.find_by_customer(16)

      online_orders_found.must_be_instance_of Array
      online_orders_found.size.must_equal 0


    end
  end
end
