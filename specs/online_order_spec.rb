require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  before do
    @new_order = Grocery::OnlineOrder.new("15", {"bread" => 5.00}, "10", "paid")
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      # Instatiate your OnlineOrder here
      @new_order.must_be_kind_of Grocery::Order

    end

    it "Can access Customer object" do
      @new_order.must_respond_to :customer
      @new_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      @new_order.status.must_equal :paid
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @new_order.total.must_equal (@new_order.order_total + 10)
    end

    it "Doesn't add a shipping fee if there are no products" do
      @new_order = Grocery::OnlineOrder.new("15", {}, "10", "paid")
      @new_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      @new_order = Grocery::OnlineOrder.new("15", {}, "10", "shipped")
      assert_raises{@new_order.add_product("Cat Food", 3.00)}
    end

    it "Permits action for pending and paid satuses" do
      @new_order.add_product("Cat Food", 3.00).must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.length.must_equal 100
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "Returns accurate information about the first online order" do
      Grocery::OnlineOrder.all[0].status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      Grocery::OnlineOrder.all[99].status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      Grocery::OnlineOrder.find('1').customer.customer_id.must_equal "25"
    end

    it "Raises an error for an online order that doesn't exist" do
      assert_raises{Grocery::OnlineOrder.find('0')}
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer('10').must_be_kind_of Array
    end

    # it "Raises an error if the customer does not exist" do
    #   assert_raises{Grocery::OnlineOrder.find_by_customer('101')}
    # end

    it "Returns an empty array if the customer has no orders" do
      Grocery::OnlineOrder.find_by_customer('101').must_be_empty
    end
  end
end
