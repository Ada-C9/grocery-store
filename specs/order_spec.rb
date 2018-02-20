require 'pry'
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
end

describe "Order Wave 2" do
  before do
    @all_orders = Grocery::Order.all
    # @orders = Grocery::Order
  end

  describe "Order.all" do
    it "Returns an array of all orders" do
      @all_orders.must_be_kind_of Array
      @all_orders.each do |order|
        order.must_be_kind_of Grocery::Order
      end
    end

    it "Returns accurate information about the first order" do
      first_item = @all_orders.first
      first_item.id.must_equal 1
      first_item.products.must_equal ({"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})
    end

    it "Returns accurate information about the last order" do
      # is the first element == {items}?
      last_item = @all_orders.last
      last_item.id.must_equal 100
      last_item.products.must_equal ({"Allspice"=>64.74, "Bran"=>14.72, "UnbleachedFlour"=>80.59})
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do

      first_item = Grocery::Order.find(1)
      first_item.id.must_equal 1
      first_item.products.must_equal ({"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})
    end

    it "Can find the last order from the CSV" do
      last_item = Grocery::Order.find(100)
      last_item.id.must_equal 100
      last_item.products.must_equal ({"Allspice"=>64.74, "Bran"=>14.72, "UnbleachedFlour"=>80.59})
    end



    it "Raises an error for an order that doesn't exist" do
      nonitem = Grocery::Order.find(101)
      nonitem.must_equal "ERROR: order does not exist"
    end
  end
end
