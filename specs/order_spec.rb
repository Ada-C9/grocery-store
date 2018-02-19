require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require 'awesome_print'
require 'csv'

Minitest::Reporters.use!

xdescribe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal 1337
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.must_be_instance_of Hash
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

  describe "#remove_product" do
    it "decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "removes the product from the collection" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      order.products.include?("banana").must_equal false
    end

    it "returns true if the product is successfully removed" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana").must_equal true
    end

    it "returns false if the product is not in the collection" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("sandwich").must_equal false
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
xdescribe "Order Wave 2" do
  describe "Order.all" do
    it "Returns an array of all orders" do
      # TODO: Your test code here!
      orders = Grocery::Order.all

      orders.must_be_instance_of Array
      orders.each do |order|
        order.must_be_instance_of Grocery::Order
      end
      orders.length.must_equal 100
    end

    it "Returns accurate information about the first order" do
      # TODO: Your test code here!
      orders = Grocery::Order.all
      first_order = orders.first

      # 1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9
      first_order.id.must_equal 1
      first_order.products["Slivered Almonds"].must_equal 22.88
      first_order.products["Wholewheat flour"].must_equal 1.93
      first_order.products["Grape Seed Oil"].must_equal 74.9
    end

    it "Returns accurate information about the last order" do
      # TODO: Your test code here!
      orders = Grocery::Order.all
      last_order = orders.last

      # 100,Allspice:64.74;Bran:14.72;UnbleachedFlour:80.59
      last_order.id.must_equal 100
      last_order.products["Allspice"].must_equal 64.74
      last_order.products["Bran"].must_equal 14.72
      last_order.products["UnbleachedFlour"].must_equal 80.59
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!
      products_found = Grocery::Order.find(1)

      # 1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9
      products_found["Slivered Almonds"].must_equal 22.88
      products_found["Wholewheat flour"].must_equal 1.93
      products_found["Grape Seed Oil"].must_equal 74.9
    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
      products_found = Grocery::Order.find(100)

      products_found["Allspice"].must_equal 64.74
      products_found["Bran"].must_equal 14.72
      products_found["UnbleachedFlour"].must_equal 80.59
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!
      products_found = Grocery::Order.find(101)

      products_found.must_be_nil
    end
  end
end
