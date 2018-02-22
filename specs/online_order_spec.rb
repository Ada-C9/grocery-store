require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'
require_relative '../lib/online_order'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      all_online_orders = Onlineorder.all
      online_order_test = all_online_orders[0]
      online_order_test.must_be_kind_of(Grocery::Order)
    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      all_online_orders = Onlineorder.all
      online_order_test = all_online_orders[0]
      online_order_test.customer.must_be_instance_of(Grocery::Customer)
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      all_online_orders = Onlineorder.all
      online_order_test = all_online_orders[0]
      online_order_test.status.must_equal(:complete)
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      # # TODO: Your test code here!
      all_online_orders = Onlineorder.all
      online_order_test = all_online_orders[0]
      online_order_test.total.must_be_within_delta 180.67, 0.1

    end

    it "Doesn't add a shipping fee if there are no products" do
      an_order = Onlineorder.new('4',nil,nil,nil,nil)
      an_order.total.must_equal(0)

    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      #completed
      online_orders = Onlineorder.all
      proc {online_orders.add_product('apple',4.00,:complete)}.must_raise 'Input is not pending or paid'

      #shipped
      online_orders = Onlineorder.all
      proc {online_orders.add_product('apple',4.00,:shipped)}.must_raise 'Input is not pending or paid'
    end

    it "Permits action for pending and paid satuses" do
      # # TODO: Your test code here!
      # online_orders = Onlineorder.all
      #
      # online_orders.add_product('very expensive apple for testing',400.00,:pending)
      # online_orders[online_orders.length-1].products.must_equal 'very expensive apple for testing'

    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      online_orders = Onlineorder.all
      online_orders.must_be_kind_of Array

    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      online_orders = Onlineorder.all
      online_orders[0].id.must_equal "1"
      online_orders[0].status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      online_orders = Onlineorder.all
      online_orders[online_orders.length-1].id.must_equal "100"
      online_orders[online_orders.length-1].status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
      online_orders = Onlineorder.all
      searched = online_orders.find('45')
      searched.id.must_equal '45'

    end

    it "Raises an error for an online order that doesn't exist" do
      # # TODO: Your test code here!
      # online_orders = Onlineorder.all
      # searched = online_orders.find('fsdfsd')
      # proc {searched}.must_raise 'Input does not exist in the list'
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
