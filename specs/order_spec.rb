require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

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

  describe "remove_product" do
    it "Decreses the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("banana")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
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

      orders = CSV.read('support/orders.csv', 'r')

      Grocery::Order.all.length.must_equal orders.length

      Grocery::Order.all.must_be_kind_of Array

    end

    it "Returns accurate information about the first order" do
      first_order_index = 0

      # Order #1 on file:
      file_order = CSV.read('support/orders.csv', 'r')[first_order_index]

      # Create all_orders on Grocery module
      Grocery::Order.all
      find =  Grocery::Order.all

      # Create string of the order #1:
      order = ""
      products = find[first_order_index][1].keys
      price = find[first_order_index][1].values

      (products.size - 1).times do |i|
        order += "#{products[i]}:#{price[i]};"
      end

      order += "#{products.last}:#{price.last}"

      # create array of the first_order:
      first_order = [find[first_order_index][0], order]

      # evaluate:
      file_order.must_equal first_order
    end

    it "Returns accurate information about the last order" do
      last_order_index = 99

      # Order #1 on file:
      file_order = CSV.read('support/orders.csv', 'r')[last_order_index]

      # Create all_orders on Grocery module
      Grocery::Order.all
      find =  Grocery::Order.all

      # Create string of the order #1:
      order = ""
      products = find[last_order_index][1].keys
      price = find[last_order_index][1].values

      (products.size - 1).times do |i|
        order += "#{products[i]}:#{price[i]};"
      end

      order += "#{products.last}:#{price.last}"

      # create array of the first_order:
      first_order = [find[last_order_index][0], order]

      # evaluate:
      file_order.must_equal first_order

    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # Order #1 on file:
      orders = CSV.read('support/orders.csv', 'r')[0][0]

      # Create all orders on Grocery module and search for the order #1:
      Grocery::Order.all
      find =  Grocery::Order.find(1)

      orders.must_equal find[0]
    end

    it "Can find the last order from the CSV" do
      # Order #1 on file:
      orders = CSV.read('support/orders.csv', 'r')[99][0]

      # Create all orders on Grocery module and search for the order #100:
      Grocery::Order.all
      find =  Grocery::Order.find(100)

      orders.must_equal find[0]
    end

    it "Raises an error for an order that doesn't exist" do
      # Order that doesnt exists on file:
      error = "Order doesn't exist!"
      # Create all orders on Grocery module and search for the order #101 - doesnt exist!:
      Grocery::Order.all
      find =  Grocery::Order.find(101)

      error.must_equal find

    end
  end
end
