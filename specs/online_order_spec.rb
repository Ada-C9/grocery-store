require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    before do
      @all_online_orders = Grocery::Order.all
      @online_order = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},25,:complete)
    end

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
      no_products = Grocery::OnlineOrder.new(507,{},200,"pending")
      no_products.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      @o_order_1 = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},25,:completed)
      before_count = @o_order_1.products.count
      @o_order_1.add_product("coconut", 20.01)
      @o_order_1.products.count.must_equal before_count
      @o_order_1.products.has_key?("coconut").must_equal false
    end

    it "Permits action for pending and paid satuses" do
      @o_order_2 = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},25,:paid)

      before_count = @o_order_2.products.count

      @o_order_2.add_product("coconut", 20.01)
      @o_order_2.products.count.must_equal before_count + 1
      @o_order_2.products.has_key?("coconut").must_equal true
    end
    end
  end

  xdescribe "OnlineOrder.all" do
    xit "Returns an array of all online orders" do
      # TODO: Your test code here!
    end

    xit "Returns accurate information about the first online order" do
      # TODO: Your test code here!
    end

    xit "Returns accurate information about the last online order" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.find" do
    xit "Will find an online order from the CSV" do
      # TODO: Your test code here!
    end

    xit "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    xit "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    xit "Returns an empty array if the customer does not exist" do
      # TODO: Your test code here!
    end

    xit "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
