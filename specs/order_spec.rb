require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'minitest/reporters'
require_relative '../lib/order'
require_relative '../lib/customer'

Minitest::Reporters.use!

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
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
    # Arrange
    # ap Grocery::Order.all
    # Act
    result = Grocery::Order.all
    # Assert
    result.must_be_kind_of Array
    result.length.must_equal 100
    end

    it "Returns accurate information about the first order" do
      # Arrange
      # ap Grocery::Order.all
      # Act
      first_order = Grocery::Order.all[0]
      # Assert
      first_order.id.must_equal "1"
      first_order.products.length.must_equal 3
      first_order.products.must_be_kind_of Hash
    end

    it "Returns accurate information about the last order" do
      # TODO: Your test code here!
      # Arrange
      # ap Grocery::Order.all
      # Act
      last_order = Grocery::Order.all[99]
      # Assert
      last_order.id.must_equal "100"
      last_order.products.length.must_equal 3
      last_order.products["UnbleachedFlour"].must_equal "80.59"
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do

      order_search_first = Grocery::Order.find("1")
      # Assert
      order_search_first.id.must_equal "1"
      order_search_first.products["Slivered Almonds"].must_equal "22.88"
      order_search_first.products.length.must_equal 3
    end

    it "Can find the last order from the CSV" do

      order_search_last = Grocery::Order.find("100")
      # Assert
      order_search_last.id.must_equal "100"
      order_search_last.products.length.must_equal 3
      order_search_last.products["UnbleachedFlour"].must_equal "80.59"
    end

    it "Raises an error for an order that doesn't exist" do

      proc { Grocery::Order.find("101") }.must_raise NoMethodError
    end
  end
end
