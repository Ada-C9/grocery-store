require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
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

  describe "#add_product" do
    it "Increases the number of products" do
      # Arrange
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      # Act
      order.add_product("salad", 4.25)

      # Assert
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

  #Basically the opposite of #add_product
 describe "#remove_product" do
  it "Decreases the number of products" do
   products = { "banana" => 1.99, "cracker" => 3.00 }
   before_count = products.count
   order = Grocery::Order.new(1337, products)

   # based only on the first argument or name of product
   order.remove_product("banana")
   # remove instead of add
   expected_count = before_count - 1
   order.products.count.must_equal expected_count
  end

  it "Is removed to the collection of products" do
   products = { "banana" => 1.99, "cracker" => 3.00 }
   order = Grocery::Order.new(1337, products)

   order.remove_product("sandwich")
   order.products.include?("sandwich").wont_equal true
  end

  it "Returns true if the product is removed" do
   products = { "banana" => 1.99, "cracker" => 3.00 }

   order = Grocery::Order.new(1337, products)
   before_total = order.total

   result = order.remove_product("banana")
   after_total = order.total

   # Returns true if the before total != after total when item is removed
   result.must_equal true
   before_total.wont_equal after_total
  end

  it "Returns false if the product is new" do
   products = { "banana" => 1.99, "cracker" => 3.00 }
   order = Grocery::Order.new(1337, products)

   result = order.remove_product("salad")
   result.must_equal false
  end

 end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all" do

    it "Returns an array of all orders" do
      # wait don't I need to put an "arrange" statement here??

      all_orders = Grocery::Order.all
      # all_orders.must_be_kind_of Array
      all_orders.class.must_equal Array

      all_orders.each do |order|
        order.must_be_instance_of Grocery::Order
      end

      all_orders.count.must_equal 100
    end

    it "Returns accurate information about the first order" do

      all_orders = Grocery::Order.all
      # binding.pry


      all_orders[0].id.must_equal 1

      all_orders[0].products.must_be_kind_of Hash


    end

    it "Returns accurate information about the last order" do
      all_orders = Grocery::Order.all

      all_orders[-1].id.must_equal 100
      all_orders[-1].products.must_be_kind_of Hash


    end
  end

  describe "Order.find" do

  before do
    @order_class = Grocery::Order
  end


    it "Can find the first order from the CSV" do

      @order_class.find(1).must_be_instance_of Grocery::Order

    end

    it "Can find the last order from the CSV" do

      @order_class.find(100).must_be_instance_of Grocery::Order

    end

    it "Returns nil for an order that doesn't exist" do

      @order_class.find(500).must_be_nil


    end
  end
end
