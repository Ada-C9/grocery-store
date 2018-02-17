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
    @order_id = 3
    @products = {"Ramen" => 0.99, "Sake" => 7.99}
    @cust_id = 22
    @fill_status = "processing"

    @online_order = Grocery::OnlineOrder.new(@order_id, @products, @cust_id, @fill_status)

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
      order_id = 3
      products = {}
      cust_id = 22
      fill_status = "pending"

      new_order = Grocery::OnlineOrder.new(order_id, products, cust_id, fill_status)
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

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
