require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'

# TODO: uncomment the next line once you start wave 3


# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      result = Grocery::OnlineOrder.all[0]
      result.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      id = Grocery::OnlineOrder.all[0].customer

      result = Grocery::Customer.find(id)

      result.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      result = Grocery::OnlineOrder.all[0].status

      result.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      result = Grocery::OnlineOrder.all[0].total

      result.must_equal 180.68

    end
    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      result = Grocery::OnlineOrder.new(101, products, 13)
      result.total.must_be_nil
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # Arrange
      order = Grocery::OnlineOrder.all[2]

      # Act
      result = order.add_product("Seaweed Salad", 5.78)

      # Assert
      result.must_be_nil
    end

    it "Permits action for pending and paid satuses" do
      # Arrange
      order = Grocery::OnlineOrder.all[1]

      # Act
      result = order.add_product("Seaweed Salad", 5.78)

      # Assert
      result.must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
        result = Grocery::OnlineOrder.all
        result.must_be_kind_of Array
        result[1].must_be_kind_of Grocery::Order
        result[1].must_be_kind_of Grocery::OnlineOrder
    end

    it "Returns accurate information about the first online order" do
      result = Grocery::OnlineOrder.all[0]

      result.id.must_equal 1
      result.status.must_equal :complete
      result.total.must_equal 180.68

    end

    it "Returns accurate information about the last online order" do
      result = Grocery::OnlineOrder.all[-1]

      result.id.must_equal 100
      result.status.must_equal :pending
      result.total.must_equal 182.04

    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      result = Grocery::OnlineOrder.find(1)
    end

    it "Raises an error for an online order that doesn't exist" do
      assert_raises do #Fails no exceptions are raised
        Grocery::OnlineOrder.find(101)
      end
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      result = Grocery::OnlineOrder.find_by_customer(35)

      result.length.must_equal 4
    end

    it "Raises an error if the customer does not exist" do
      proc {Grocery::OnlineOrder.find_by_customer(1337)}.must_raise Grocery::CustomerError
    end

    it "Returns an empty array if the customer has no orders" do
      result = Grocery::OnlineOrder.find_by_customer(22)
      result.length.must_equal 0
    end
  end
end
