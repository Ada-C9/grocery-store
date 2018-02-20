require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
require_relative '../lib/order'
Minitest::Reporters.use!


describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1, products, 3)

      online_order.must_be_kind_of Grocery::Order

      # Instatiate your OnlineOrder here
      online_order.must_be_kind_of Grocery::Order
    end

    #it "Can access Customer object" do
    # TODO: Your test code here!
    #end

    it "Can access the online order status" do

      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1,products,3)
      online_order.order_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1337, products, 26, :complete)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2) + 10

      online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
      products = {}
      online_order = Grocery::OnlineOrder.new(1337, products, 26, :complete)
      expected_total = 0
      online_order.total.must_equal expected_total
    end
  end

  xdescribe "#add_product" do
    xit "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
      online_order_shipped = Grocery::OnlineOrder.new(27, {"Apples" => 61.87, "Garlic" => 64.36}, 27, :shipped)
      online_order_shipped.add_product("apple", 12.3).must_be_nil

      online_order_processing = Grocery::OnlineOrder.new(16, {"Ricemilk" => 5.07}, 10, :processing)
      online_order_processing.add_product("apple", 12.3).must_be_nil

      online_order_complete = Grocery::OnlineOrder.new(38, {"Kale" => 90.99, "Miso" => 90.2}, 2, :complete)
      online_order_complete.add_product("apple", 12.3).must_be_nil
    end


    it "Permits action for pending and paid satuses" do
      online_order_pending = Grocery::OnlineOrder.new(6, {"Peaches" => 46.34}, 14, :pending)
      online_order_pending.must_respond_to(:add_product)
      online_order_pending.add_product("apple", 12.3).must_equal true

      online_order_paid = Grocery::OnlineOrder.new(13, {"Lettuce" => 37.94, "Paper" => 23.93, "Flaxseed" => 23.67}, 19, :paid)
      online_order_paid.must_respond_to(:add_product)
      online_order_paid.add_product("apple", 12.3).must_equal true
    end
  end


  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here
      Grocery::OnlineOrder.all.must_be_kind_of Array
      Grocery::OnlineOrder.all[0].must_be_kind_of Grocery::OnlineOrder
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      product_list = {"Lobster"=> 17.18, "Annatto seed"=> 58.38, "Camomile"=> 83.21}
      Grocery::OnlineOrder.all.first.id.must_equal 1
      Grocery::OnlineOrder.all.first.products.must_equal product_list
      Grocery::OnlineOrder.all.first.customer_id.must_equal 25
      Grocery::OnlineOrder.all.first.order_status.must_equal :complete

    end


    it "Returns accurate information about the last online order" do

      last_order = Grocery::OnlineOrder.all[-1]
      last_order.id.must_equal 100

      product_list = {"Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63 }
      last_order.products.must_equal product_list
      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.products.must_equal product_list
      Grocery::OnlineOrder.all.last.customer_id.must_equal 20
      Grocery::OnlineOrder.all.last.order_status.must_equal :pending

    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do

      result = Grocery::OnlineOrder.find(23)
      result.must_be_kind_of Grocery::OnlineOrder
      result.id.must_equal 23
    end

    it "Raises an error for an online order that doesn't exist" do
      Grocery::OnlineOrder.find(101).must_equal nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(25).length.must_equal 6
      Grocery::OnlineOrder.find_by_customer(25).must_be_kind_of Array
    end

    it "Raises an error if the customer does not exist" do
      Grocery::OnlineOrder.find_by_customer(999).must_be_nil
    end

    xit "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
