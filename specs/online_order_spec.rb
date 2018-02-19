require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/customer'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free!
# Here we'll only test things that are different.

describe "OnlineOrder" do

  products = {"apples": 3.24, "salad": 10.92, "crackers": 5.33}
  online_order = Grocery::OnlineOrder.new(12, products, 4, "pending")

  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      customer = online_order.customer
      customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      value = online_order.status
      value.must_equal :pending

    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      total = online_order.total
      sum = online_order.products.values.sum
      expected_total = (sum*1.075)+10
      total.must_equal expected_total.round(2)
    end

    it "Doesn't add a shipping fee if there are no products" do
      empty_order = Grocery::OnlineOrder.new(3,{},4,"pending")
      empty_order.total.must_equal 0
    end
  end

  describe "#add_product" do

    shipped_order = Grocery::OnlineOrder.new(3,products,3,"shipped")
    completed_order = Grocery::OnlineOrder.new(3,products,3,"completed")
    processing_order = Grocery::OnlineOrder.new(3,products,3,"processing")
    pending_order = Grocery::OnlineOrder.new(3,products,3,"pending")
    paid_order = Grocery::OnlineOrder.new(3,products,3,"paid")

    it "Does not permit action for processing, shipped or completed statuses" do

      shipped_order.add_product("oranges", 4.32)
      completed_order.add_product("oranges", 4.32)
      processing_order.add_product("oranges", 4.32)

      shipped_order.products.length.must_equal 3
      completed_order.products.length.must_equal 3
      processing_order.products.length.must_equal 3

    end

    it "Permits action for pending and paid satuses" do

      pending_order.add_product("oranges", 4.32)
      paid_order.add_product("oranges", 4.32)

      pending_order.products.length.must_equal 4
      paid_order.products.length.must_equal 4

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      list = Grocery::OnlineOrder.all
      list.must_be_kind_of Array
      list[0].must_be_kind_of Grocery::OnlineOrder
    end

    it "Returns accurate information about the first online order" do

      list_item = Grocery::OnlineOrder.all[0]
      csv_row = CSV.read('support/online_orders.csv')[0]
      csv_row[0].to_i.must_equal list_item.id
      csv_row[2].to_i.must_equal list_item.customer_id
      csv_row[3].to_sym.must_equal list_item.status
      products_string = ""
      list_item.products.each do |k, v|
        products_string += "#{k}:#{v};"
      end
      products_string = products_string.chomp(";")

      csv_row[1].must_equal products_string

    end

    it "Returns accurate information about the last online order" do

      list_item = Grocery::OnlineOrder.all[-1]
      csv_row = CSV.read('support/online_orders.csv')[-1]
      csv_row[0].to_i.must_equal list_item.id
      csv_row[2].to_i.must_equal list_item.customer_id
      csv_row[3].to_sym.must_equal list_item.status
      products_string = ""
      list_item.products.each do |k, v|
        products_string += "#{k}:#{v};"
      end
      products_string = products_string.chomp(";")

      csv_row[1].must_equal products_string
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      result = Grocery::OnlineOrder.find(23)
      result.must_be_kind_of Grocery::OnlineOrder
      result.id.must_equal 23

    end

    it "Returns nil for an online order that doesn't exist" do
      result = Grocery::OnlineOrder.find(180)
      result.must_be_nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      result = Grocery::OnlineOrder.find_by_customer(8)

      result.must_be_kind_of Array
      result[0].customer_id.must_equal 8
    end

    it "Raises an error if the customer does not exist" do
      result = Grocery::OnlineOrder.find_by_customer(78)
      result.must_be_nil
    end

    it "Returns an empty array if the customer has no orders" do
      result = Grocery::OnlineOrder.find_by_customer(22)

      result.must_be_kind_of Array
      result.length.must_equal 0

    end
  end
end
