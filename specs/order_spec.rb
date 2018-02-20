require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

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

  describe "remove_product" do
    it "Returns true if the product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("banana")
      result.must_equal false
    end

    it "Returns true if the product is removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("pears")
      result.must_equal true
    end
  end

end

describe "Order Wave 2" do
  # Arrange
  orders = Grocery::Order.all
  describe "Order.all" do
    it "Returns an array of all orders" do
      # Action
      result = orders
      # # Assertion
      result.class.must_equal Array
    end

    it "Returns accurate information about the first order" do
      # Arrange
      first_order =
        { "Slivered Almonds" => 22.88,
          "Wholewheat flour" => 1.93,
          "Grape Seed Oil" => 74.9
        }
      # Action
      result = orders[0].products
      # Assertion
      result.must_equal first_order
    end

    it "Returns accurate information about the last order" do
      # Arrange
      last_products =
        { "Allspice" => 64.74,
          "Bran" => 14.72,
          "UnbleachedFlour" => 80.59
        }
      # Action
      result = orders[-1].products
      # Assertion
      result.must_equal last_products
    end
  end
end

describe "Order.find" do
  it "Can find the first order from the CSV" do
    # Arrange
    first_order = 1
    # Action
    found_order = Grocery::Order.find(1)
    # Assertion
    found_order.id.must_equal first_order
  end

  it "Can find the last order from the CSV" do
    # Arrange
    last_order = 100
    # Action
    result = Grocery::Order.find(100).id
    # Assertion
    result.must_equal last_order
  end

  it "Raises an error for an order that doesn't exist" do
    # Arrange
    id = 121
    # Action
    result = Grocery::Order.find(id)
    # Assertion
    result.must_equal ArgumentError
  end
end
