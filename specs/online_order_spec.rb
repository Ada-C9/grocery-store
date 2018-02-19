require 'pry'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'awesome_print'


# TODO: uncomment the next line once you start wave 3
require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      id = 1
      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      customer = 25
      status = :complete

      online_order = Grocery::OnlineOrder.new(id, products, customer, status)
      online_order.must_respond_to :products
      online_order.products.length.must_equal 3
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = 1
      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      customer = 25
      status = :complete

      online_order = Grocery::OnlineOrder.new(id, products, customer, status)

      online_order.must_respond_to :id
      online_order.id.must_equal id
    end

    it "Can access the online order status" do
      id = 1
      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      customer = 25
      status = :complete

      online_order = Grocery::OnlineOrder.new(id, products, customer, status)

      online_order.must_respond_to :status
      online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      id = 1
      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      customer = 25
      status = :complete

      online_order = Grocery::OnlineOrder.new(id, products, customer, status)

      online_order.total.must_equal 180.68
    end

    it "Doesn't add a shipping fee if there are no products" do
      id = 1
      products = {}
      customer = 25
      status = :complete

      online_order = Grocery::OnlineOrder.new(id, products, customer, status)

      online_order.total.must_equal nil
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      id = 1
      products = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      customer = 25
      status = :complete

      online_order = Grocery::OnlineOrder.new(id, products, customer, status)

      online_order.add_product("Annatto seed", 58.38).must_be_nil
    end

    it "Permits action for pending and paid satuses" do
      online_order = Grocery::OnlineOrder.new(1, {"Lobster" => 17.18, "Camomile" => 83.21}, 25, :pending)

      online_order.add_product("Annatto seed", 58.38).must_equal true
      online_order.products.length.must_equal 3
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all_orders.must_be_kind_of Array
      Grocery::OnlineOrder.all_orders.length.must_equal 100
    end

    it "Returns accurate information about the first online order" do
      Grocery::OnlineOrder.all_online_orders.first.id.must_equal "1"
      Grocery::OnlineOrder.all_online_orders.first.products.length.must_equal 3
    end

    it "Returns accurate information about the last online order" do
      Grocery::OnlineOrder.all_online_orders.last.id.must_equal "100"
      Grocery::OnlineOrder.all_online_orders.last.products.length.must_equal 3
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      Grocery::OnlineOrder.find_online_order("1").customer.must_equal "25"
      Grocery::OnlineOrder.find_online_order("25").products.must_equal ({"Cabbage"=>"52.42", "Tea"=>"54.52", "Custard ApplesDaikon"=>"7.65", "Wheat"=>"59.56"})
    end

    it "Raises an error for an online order that doesn't exist" do
      Grocery::OnlineOrder.find_online_order("0").must_be_nil
      Grocery::OnlineOrder.find_online_order("205").must_be_nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer("28").length.must_equal 3

      Grocery::OnlineOrder.find_by_customer("28").must_be_kind_of Array
    end

    it "Raises an error if the customer does not exist" do
      Grocery::OnlineOrder.find_by_customer("300").must_be_nil
      Grocery::OnlineOrder.find_by_customer("0").must_be_nil
    end

    xit "Returns an empty array if the customer has no orders" do
      Grocery::Customer.new("36", "lilyxsky@ada.com", "3016, First Ave, Seattle, WA, 98121")
      online_order = Grocery::OnlineOrder.new("", {}, "36", :pending)

      online_order.find_by_customer("36").must_equal []
    end
  end
end
# binding.pry
