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
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      Grocery::OnlineOrder.new(1337, {}, 10, :pending).must_be_kind_of Grocery::Order
    end

    # it "Can access Customer object" do
    #   # TODO: Your test code here!
    # end

    it "Can access the online order status" do
      Grocery::OnlineOrder.new(1337, {}, 10, :pending).status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      Grocery::OnlineOrder.new(1337, {"Bananas" => 2.99}, 10, :pending).total.must_equal 13.21
    end

    it "Doesn't add a shipping fee if there are no products" do
      Grocery::OnlineOrder.new(1337, {}, 10, :pending).total.must_equal 0.00
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      processing_order = Grocery::OnlineOrder.new(1337, {}, 10, :processing)
      proc { processing_order.add_product }.must_raise ArgumentError

      shipped_order = Grocery::OnlineOrder.new(1337, {}, 10, :shipped)
      proc { shipped_order.add_product }.must_raise ArgumentError

      completed_order = Grocery::OnlineOrder.new(1337, {}, 10, :completed)
      proc { completed_order.add_product }.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      pending_order = Grocery::OnlineOrder.new(1337, {}, 10, :pending)
      pending_order.add_product("sandwich", 4.25)
      pending_order.products.include?("sandwich").must_equal true

      paid_order = Grocery::OnlineOrder.new(1337, {}, 10, :paid)
      paid_order.add_product("sandwich", 4.25)
      paid_order.products.include?("sandwich").must_equal true
    end
  end

  describe "#remove_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      processing_order = Grocery::OnlineOrder.new(1337, {}, 10, :processing)
      proc { processing_order.remove_product }.must_raise ArgumentError

      shipped_order = Grocery::OnlineOrder.new(1337, {}, 10, :shipped)
      proc { shipped_order.remove_product }.must_raise ArgumentError

      completed_order = Grocery::OnlineOrder.new(1337, {}, 10, :completed)
      proc { completed_order.remove_product }.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_instance_of(Array)
    end

    it "Returns accurate information about the first online order" do
      Grocery::OnlineOrder.all.first.id.must_equal 1
      Grocery::OnlineOrder.all.first.customer_id.must_equal 25
      Grocery::OnlineOrder.all.first.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.customer_id.must_equal 20
      Grocery::OnlineOrder.all.last.status.must_equal :pending
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

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
