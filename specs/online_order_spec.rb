require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'awesome_print'
require_relative '../lib/online_order'
require 'csv'
require 'pry'


describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = OnlineOrder.new(67, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})
      online_order.must_be_kind_of Grocery::Order
      online_order.id.must_equal 67
    end

    # Ignored because I chose to not make Customer class.
    xit "Can access Customer object" do
      online_order = OnlineOrder.new(1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})
      test = online_order.find_by_customer(1)
      test.must_equal ([1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00}])
    end

    it "Can access the online order status" do
      online_order = OnlineOrder.new(1, 1, :paid, {"tempeh":4.99, "pokebowl":9.00})
      test = online_order.status
      test.must_equal (:paid)
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      online_order = OnlineOrder.new(1, 1, "paid", {"tempeh":4.99, "pokebowl":9.00})

      order_total = online_order.total
      order_total.must_equal (10 + ((4.99 + 9) * 1.075).round(2))
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = OnlineOrder.new(1, 1, "paid", {})
      test = online_order.total
      test.must_equal 0
    end

    describe "#add_product" do
      it "Does not permit action for processing, shipped or completed statuses" do
        online_order = OnlineOrder.new(1, 1, :processing, {"tempeh":4.99, "pokebowl":9.00})
        online_order.add_product("nips", 1.00, 1).must_be_nil
      end
    end

    it "Permits action for pending and paid satuses" do
      online_order = OnlineOrder.new(1, 1, :pending, {"tempeh":4.99, "pokebowl":9.00})
      test = online_order.add_product("nips", 1.00, 1)
      test.must_equal true
      online_order = OnlineOrder.new(1, 1, :paid, {"tempeh":4.99, "pokebowl":9.00})
      test = online_order.add_product("nips", 1.00, 1)
      test.must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      result = OnlineOrder.all
      result.first.is_a?(OnlineOrder).must_equal true
      result.count.must_equal 100

    end

    it "Returns accurate information about the first online order" do
      result = OnlineOrder.all
      result[0].products.must_equal (
        {
        "Lobster" => 17.18,
        "Annatto seed" => 58.38,
        "Camomile" => 83.21
        }
      )
    end

    it "Returns accurate information about the last online order" do
      result = OnlineOrder.all
      result[-1].products.must_equal (
        {
        "Amaranth" => 83.81,
        "Smoked Trout" => 70.6,
        "Cheddar" => 5.63
        }
      )
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      result = OnlineOrder.find(50)
      result.must_equal  (
        {
        "Star Fruit" => 51.8,
        }
      )
    end

    it "Raises an error for an online order that doesn't exist" do
      result = OnlineOrder.find(1000)
      result.must_equal false
    end

  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      result = OnlineOrder.find_by_customer(25)
      result.first.must_be_kind_of OnlineOrder
      result.must_be_kind_of Array
    end

    it "Returns empty array if the customer does not exist" do
      result = OnlineOrder.find_by_customer(1000)
      result.must_be_kind_of Array
      result.count.must_equal 0
    end
  end
end
