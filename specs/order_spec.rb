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
      # Arrange - feed information for method to work with

      products_list = ["Slivered Almonds", "22.88"], ["Wholewheat flour", "1.93"],["Grape Seed Oil" , "74.9"]

      results = Grocery::Order.all

      results.first.id.must_equal 1
      results.first.products.must_equal products_list[0]

    end

    xit "Returns accurate information about the last order" do

      products_list = ["Allspice", "64.74"], ["Bran", "14.72"],["Unbleached Flour", "80.59"]

      results = Grocery::Order.all

      results.last.id.must_equal 100
      results.last.products.must_equal products_list[-1]
      # something interesting happening here not sure why this test is passing

    end
  end

  describe "Order.find" do
    xit "Can find the first order from the CSV" do

      results = Grocery::Order.find(1)
      results.id.must_equal 1
      results.must_be_kind_of Grocery::Order
    end

    it "Can find the last order from the CSV" do
      results = Grocery::Order.find(100)
      results.id.must_equal 100
      results.must_be_kind_of Grocery::Order
    end

    xit "Raises an error/nil for an order that doesn't exist" do
      results = Grocery::Order.find(3)
      results.must_be_nil
    end
  end
end
