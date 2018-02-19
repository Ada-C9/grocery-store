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
    @all_online_orders = Grocery::Order.all
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
      before_count = @online_order.products.count

      @online_order.add_product("coconut", 20.01)
      @online_order.products.count.must_equal before_count
      @online_order.products.has_key?("coconut").must_equal false
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.all" do
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

  xdescribe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
