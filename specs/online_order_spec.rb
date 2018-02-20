require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'


xdescribe "Onlineorder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      Online_order = Grocery::Online_order.new(1, {"pickles"=> 3}, {"chips"=> 10}, :pending)
      Online_order.must_be_kind_of Grocery::Order
    end

    xit "Can access Customer object" do
      # TODO: Your test code here!
    end

    xit "Can access the online order status" do
      # TODO: Your test code here!
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Online_order.new(1337, products)

      sum = products.values.inject(0, :+)

      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total + 10
    end

    xit "Doesn't add a shipping fee if there are no products" do
      # TODO: Your test code here!
    end
  end

  describe "#add_product" do
    xit "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    xit "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.all" do
    xit "Returns an array of all online orders" do
      # TODO: Your test code here!
    end

    xit "Returns accurate information about the first online order" do
      # TODO: Your test code here!
    end

    xit "Returns accurate information about the last online order" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.find" do
    xit "Will find an online order from the CSV" do
      # TODO: Your test code here!
    end

    xit "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.find_by_customer" do
    xit "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    xit "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    xit "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
