require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use!

require_relative '../lib/online_order'
# You may also need to require other classes here
require_relative '../lib/order'
require_relative '../lib/customer'

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  before do
    @id = 3
    @products = {"Ramen" => 0.99, "Sake" => 7.99}
    @cust_id = 22
    @fill_status = "processing"

    @online_order = Grocery::OnlineOrder.new(@id, @products, @cust_id, @fill_status)

  end

  describe "#initialize" do
    it "Is a kind of Order" do
      # Instatiate your OnlineOrder here
      @online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      @online_order.fill_status.must_equal :processing
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      order_total = 19.65
      @online_order.total.must_equal order_total
    end

    it "Doesn't add a shipping fee if there are no products" do
      order_total = 0
      id = 3
      products = {}
      cust_id = 22
      fill_status = "pending"

      new_order = Grocery::OnlineOrder.new(id, products, cust_id, fill_status)
      new_order.total.must_equal order_total
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      item_to_add = "Ramen"
      price_of_item = 0.99

      @online_order.add_product(item_to_add, price_of_item).must_be_nil
    end

    it "Permits action for pending and paid satuses" do
      @fill_status = "pending"
      item_to_add = "Ramen"
      price_of_item = 0.99

      @online_order.add_product(item_to_add, price_of_item).must_be_nil
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.class.must_equal Array
    end

    it "Returns accurate information about the first online order" do
      first_id = 1
      first_product_hash = {"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21}
      first_customer_id = 25
      first_order_status = :complete
      Grocery::OnlineOrder.all.first.id.must_equal first_id
      Grocery::OnlineOrder.all.first.products.must_equal first_product_hash
      Grocery::OnlineOrder.all.first.customer_id.must_equal first_customer_id
      Grocery::OnlineOrder.all.first.fill_status.must_equal first_order_status
    end

    it "Returns accurate information about the last online order" do
      last_id = 100
      last_product_hash = {"Amaranth" => 83.81, "Smoked Trout" => 70.6, "Cheddar" => 5.63}
      last_customer_id = 20
      last_order_status = :pending

      Grocery::OnlineOrder.all.last.id.must_equal last_id
      Grocery::OnlineOrder.all.last.products.must_equal last_product_hash
      Grocery::OnlineOrder.all.last.customer_id.must_equal last_customer_id
      Grocery::OnlineOrder.all.last.fill_status.must_equal last_order_status
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      id = 34
      product_hash = {"Brown Flour" => 16.12, "Choy Sum" => 87.67}
      customer_id = 7
      fill_status = :processing
      Grocery::OnlineOrder.find(34).id.must_equal id
      Grocery::OnlineOrder.find(34).products.must_equal product_hash
      Grocery::OnlineOrder.find(34).customer_id.must_equal customer_id
      Grocery::OnlineOrder.find(34).fill_status.must_equal fill_status
    end

    it "Raises an error for an online order that doesn't exist" do
      Grocery::OnlineOrder.find(200).must_be_nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(7).class.must_equal Array
    end

    it "Returns accurate online orders for a specific customer ID" do
      # can't test for the same things as OnlineOrder.find because this returns an array of all orders for a particular customer, not the instance of the OnlineOrder
      online_cust7 = Grocery::OnlineOrder.find_by_customer(9)
      customer_id = 9
      online_cust7.each do |online_order|
        online_order.customer_id.must_equal customer_id
      end
    end

    it "Returns an accurate count of online orders for a specific customer ID" do
      online_cust7 = Grocery::OnlineOrder.find_by_customer(9)
      online_cust7.count.must_equal 2
    end

    it "Raises an error if the customer does not exist" do
      Grocery::OnlineOrder.find_by_customer(200).must_be_nil
    end

    it "Returns an empty array if the customer has no orders" do # not sure how to get an existing customer with no orders with our current set up of importing OnlineOrders from a CSV
      Grocery::OnlineOrder.find_by_customer(22).count.must_be 0 
    end
  end
end
