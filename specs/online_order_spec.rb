require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require_relative '../lib/online_order'



# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      products = [{"apple" => 5.50}]
      online_order = OnlineOrder.new(101,86,:pending,products)
      online_order.must_be_kind_of(Grocery::Order)
    end

    # it "Can access Customer object" do
    #   # TODO: Your test code here!
    # end

    it "Can access the online order status" do
      products = [{"apple" => 5.50}]
      online_order = OnlineOrder.new(101,86,:pending,products)
      online_order.status.must_equal(:pending)
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      first_order = OnlineOrder.find(41) #Parmesan cheese:28.87
      first_order.total.wont_equal(28.87)
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = []
      empty_order = OnlineOrder.new(101,86,:pending,products)
      empty_order.total.must_equal(0)
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      products = [{"apple" => 5.50}]
      customer_id = 86
      status = :processing
      id = 101
      proc{OnlineOrder.new(id,customer_id,status,products).add_product("pear", 2.00)}.must_raise(ArgumentError)
    end

    it "Permits action for pending and paid satuses" do
      online_order = OnlineOrder.find(36) #pending
      online_order.add_product("pear",2.00)
      online_order.products.must_include("pear")

      other_order = OnlineOrder.find(37) #paid
      other_order.add_product("cake",10.00)
      other_order.products.must_include("cake")
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      result = OnlineOrder.all
      result.must_be_instance_of(Array)
    end

    it "Returns accurate information about the first online order" do
      first_order = OnlineOrder.find(1)
      first_order.products.must_include("Lobster")
    end

    it "Returns accurate information about the last online order" do
      result = OnlineOrder.all.length
      last_order = OnlineOrder.find(result)
      last_order.products.must_include("Amaranth")
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      first_order = OnlineOrder.find(1)
      first_order.must_be_instance_of(OnlineOrder)
    end

    it "Raises an error for an online order that doesn't exist" do
      invalid_id = OnlineOrder.all.length + 1
      proc { OnlineOrder.find(invalid_id) }.must_raise(ArgumentError)
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      orders = OnlineOrder.find_by_customer(12) #7 online orders
      orders.length.must_equal(7)
    end

    it "Returns an empty array if the customer does not exist" do
      orders = OnlineOrder.find_by_customer(10000)
      orders.must_be_empty
    end

    it "Returns an empty array if the customer has no orders" do
      new_customer_id = 101
      orders = OnlineOrder.find_by_customer(new_customer_id)
      orders.must_be_empty
    end
  end
end
