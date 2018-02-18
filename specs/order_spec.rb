require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require 'pry'


describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      # Arrange
      id = 1337
      order = Grocery::Order.new(id, {})

      # Act
      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      # Assert
      order.must_respond_to :products
      #why does this say must be equal to zero? because hash inside the products variable above is currently empty?
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
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
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end
# OPTIONAL ENHANCEMENT: Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
# It should return true if the item was successfully remove and false if it was not
# try using hash.except! ?
  xdescribe "#remove_product" do
    xit "Is removed from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      remove_product = order
    end

    xit "Returns false if the product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      # before_total = order.total

      result = order.add_product("banana", 4.25)
      # after_total = order.total
      #
      # result.must_equal false
      # before_total.must_equal after_total
    end

    xit "Returns true if the product is not removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      # result = order.add_product("salad", 4.25)
      # result.must_equal true
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do

  describe "Order.all" do

    before do
      @all_orders = Grocery::Order.all
    end

    it "Returns an array of all orders" do

      # all_orders = Grocery::Order.all
      # binding.pry
      @all_orders.length.must_equal 100
      @all_orders.must_be_kind_of Array

    end

    it "Returns accurate information about the first order" do

      first_row_products = {"Slivered Almonds"=>"22.88",
        "Wholewheat flour"=>"1.93",
        "Grape Seed Oil"=>"74.9"}

      Grocery::Order.all.first.id.must_equal 1
      # Grocery::Order.all.first.id.must_be_kind_of Symbol
      Grocery::Order.all.first.products.must_equal first_row_products

      end

    it "Returns accurate information about the last order" do

      last_row_products = {"Allspice"=>"64.74",
        "Bran"=>"14.72",
        "UnbleachedFlour"=>"80.59"}

      Grocery::Order.all.last.id.must_equal 100
      Grocery::Order.all.last.products.must_equal last_row_products

    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do

      first_order = Grocery::Order.find(1)

      first_order[0].must_be_instance_of Grocery::Order

    end

    it "Can find the last order from the CSV" do
      last_order = Grocery::Order.find(100)

      last_order[0].must_be_instance_of Grocery::Order

    end

    it "Return nil for an order that doesn't exist" do
      an_order = Grocery::Order.find(299)

      an_order.must_be_nil
    end
  end
end

# def find_es


# it can return false
# it can find e's
# it can return length of string
# it can take in an argument that is a string
