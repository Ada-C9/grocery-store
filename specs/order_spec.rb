require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

describe "Order Wave 1" do
  describe "#initialize" do
    xit "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    xit "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      sum = products.values.inject(0, :+)

      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total

    end

    xit "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})

      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    xit "Increases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    xit "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    xit "Returns false if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    xit "Returns true if the product is new" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    xit "Returns an array of all orders" do
      #act
      results = Grocery::Order.all
      # print results
      #assert
      results.must_be_kind_of Array
      results[0].must_be_kind_of Grocery::Order
    end

  xit "Returns accurate information about the first order" do
      # TODO: Your test code here!
      line = ["1","Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"]
    end

    xit "Returns accurate information about the last order" do
      # TODO: Your test code here!
    end
  end

  describe "Order.find" do
    xit "Can find the first order from the CSV" do
      # TODO: Your test code here!
    end

    xit "Can find the last order from the CSV" do
      # TODO: Your test code here!
    end

    xit "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
