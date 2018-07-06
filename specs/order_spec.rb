require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/order'
require 'csv'
require 'awesome_print'
require 'pry'

describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
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
    it "Returns the total from the collection of products" do
      products = {
        "banana" => 1.99,
        "cracker" => 3.00
      }

      order = Grocery::Order.new(1337, products)
      sum = products.values.inject(0, :+)

      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total
    end

    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})

      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Increases the number of products" do
      products = {
        "banana" => 1.99,
        "cracker" => 3.00
      }

      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = {
        "banana" => 1.99,
        "cracker" => 3.00
      }

      order = Grocery::Order.new(1337, products)
      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = {
        "banana" => 1.99,
        "cracker" => 3.00
      }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = {
        "banana" => 1.99,
        "cracker" => 3.00
      }

      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end
end

describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      result = Grocery::Order.all
      result.first.is_a?(Grocery::Order).must_equal true
      result.count.must_equal 100
    end

    it "Returns accurate information about the first order" do
      result = Grocery::Order.all
      result.first.id.must_equal 1
      result.first.products.include?("Wholewheat flour").must_equal true
      result.first.products["Wholewheat flour"].must_equal 1.93
    end

    it "Returns accurate information about the last order" do
      result = Grocery::Order.all
      result.last.id.must_equal 100
      result.last.products.include?("Bran").must_equal true
      result.last.products["Bran"].must_equal 14.72
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      result = Grocery::Order.find(1)
      result.id.must_equal 1
      result.products.include?("Wholewheat flour").must_equal true
      result.products["Wholewheat flour"].must_equal 1.93
    end

    it "Can find the last order from the CSV" do
      result = Grocery::Order.find(100)
      result.id.must_equal 100
      result.products.include?("Bran").must_equal true
      result.products["Bran"].must_equal 14.72
    end

    it "Returns nil if order doesn't exist" do
      result = Grocery::Order.find(1000)
      result.must_be_nil
    end
  end
end
