require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @all_online_orders = Grocery::OnlineOrder.all
    @online_order_blank = Grocery::OnlineOrder
    @online_order = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},25,:complete)
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      @all_online_orders.each do |order|
        order.must_be_kind_of Grocery::Order
      end
    end

    it "Can access the online order status" do
      @online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @online_order.total.must_equal 170.68 + 10
    end

    it "Doesn't add a shipping fee if there are no products" do
      no_products = Grocery::OnlineOrder.new(507,{},1500,"pending")
      no_products.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      @online_order2 = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},25,:complete)


      before_count = @online_order2.products.count

      @online_order2.add_product("coconut", 20.01)
      @online_order2.products.count.must_equal before_count
      @online_order2.products.has_key?("coconut").must_equal false
    end

    it "Permits action for pending and paid satuses" do
      @online_order3 = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},25,:paid)

      before_count = @online_order3.products.count

      @online_order3.add_product("coconut", 20.01)
      @online_order3.products.count.must_equal before_count + 1
      @online_order3.products.has_key?("coconut").must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      @all_online_orders.must_be_kind_of Array
      @all_online_orders.each do |order|
        order.must_be_kind_of Grocery::OnlineOrder
      end
    end

    it "Returns accurate information about the first online order" do
      first_item = @all_online_orders.first
      first_item.id.must_equal 1
      first_item.products.must_equal ({"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21})
    end

    it "Returns accurate information about the last online order" do
      last_item = @all_online_orders.last
      last_item.id.must_equal 100
      last_item.products.must_equal ({"Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63})

    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      item = @online_order_blank.find(15)
      item.id.must_equal 15
      item.products.must_equal ({"Cranberry" => 85.36})
    end

    it "Raises an error for an online order that doesn't exist" do
      nonitem = @online_order_blank.find(101)
      nonitem.must_equal "ERROR: Order not found"
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      items = Grocery::OnlineOrder.find_by_customer(23)      
      items.must_be_kind_of Array
    end

    xit "Returns an empty array if the customer does not exist" do
      # items = @online_order_blank.find_by_customer(2000)
      # items.
    end

    xit "Returns an empty array if the customer has no orders" do
      # items = @online_order_blank.find_by_customer(2000)
    end

  end
end
