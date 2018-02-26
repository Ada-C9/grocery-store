require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use!

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/onlineorder'
# You may also need to require other classes here
require_relative '../lib/order'
require_relative '../lib/customer'
# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      online_order = Grocery::OnlineOrder.new(12, {}, 4, :fulfilled)
      online_order.must_be_kind_of Grocery::Order

      # Instatiate your OnlineOrder here
      # online_order =
      # online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      customer = Grocery::Customer.new(747, "mary@ada.org", "626 Malden Ave")

      online_order = Grocery::OnlineOrder.new(12, {}, customer, :fulfilled)

      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new(12, {}, 987, :fulfilled)

      online_order.status.must_be_kind_of Symbol
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      online_order = Grocery::OnlineOrder.new(12, { "banana" => 1.99, "cracker" => 3.00 }, 987, :fulfilled)

      expected_total = ((1.99 + 3.00) * 1.075).round(2) + 10

      online_order.total.must_equal expected_total
    end

    it "Doesn't add a shipping fee if there are no products" do
        online_order = Grocery::OnlineOrder.new(12, {}, 987, :fulfilled)

        expected_total = 0

        online_order.total.must_equal expected_total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::OnlineOrder.new(1337, products, 485, :shipped)

      order.add_product("salad", 4.25)
      expected_count = before_count
      order.products.count.must_equal expected_count

    end

    it "Permits action for pending and paid satuses" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::OnlineOrder.new(1337, products, 485, :paid)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end
  end

   describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
        Grocery::OnlineOrder.all.must_be_kind_of Array

        oorder_list = Grocery::OnlineOrder.all
        oorder_list.each do |i|
          i.must_be_instance_of Grocery::OnlineOrder
        end
    end

    it "Returns accurate information about the first online order" do
      first_order = Grocery::OnlineOrder.all[0]
      first_order.id.must_equal "1"
      first_order.products.must_be_instance_of Hash
      first_order.products.must_equal({"Lobster" => "17.18", "Annatto seed" => "58.38", "Camomile" => "83.21"})
      first_order.customer.must_equal "25"
      first_order.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      last_order = Grocery::OnlineOrder.all.last
      last_order.id.must_equal "100"
      last_order.products.must_be_instance_of Hash
      last_order.products.must_equal({"Amaranth" => "83.81", "Smoked Trout" => "70.6", "Cheddar" => "5.63"})
      last_order.customer.must_equal "20"
      last_order.status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      online_order = Grocery::OnlineOrder
      online_order.find("1").must_be_instance_of Grocery::OnlineOrder

      online_order.find("1").products.must_equal ({"Lobster" => "17.18", "Annatto seed" => "58.38", "Camomile" => "83.21"})

      online_order.find("1").customer.must_equal "25"
      online_order.find("1").status.must_equal :complete
    end

    it "Raises an error for an online order that doesn't exist" do
      Grocery::OnlineOrder.find(0).must_equal nil
      Grocery::OnlineOrder.find(300).must_equal nil

    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(25).must_be_instance_of Grocery::OnlineOrder

      Grocery::OnlineOrder.find_by_customer(25).products.must_equal ({"Lobster" => "17.18", "Annatto seed" => "58.38", "Camomile" => "83.21"})

      Grocery::OnlineOrder.find_by_customer(25).status.must_equal :complete
    end

    it "Raises an error if the customer does not exist" do
      Grocery::OnlineOrder.find_by_customer(0).must_equal nil
      Grocery::OnlineOrder.find_by_customer(300).must_equal nil
    end

    it "Returns an empty array if the customer has no orders" do

    end
  end
end
