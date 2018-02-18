require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
Minitest::Test.make_my_diffs_pretty!
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
  describe "Order.all" do

    it "Returns an array of all orders" do
      array_of_all_orders = Grocery::Order.all

      array_of_all_orders.must_be_kind_of Array

      assert array_of_all_orders.all? { |order| order.class == Grocery::Order}

    end

    it "Returns accurate information about the first order" do
      expected_first_order_id = 1
      # TODO: What happens this if this changes??
      expected_first_order_products = {"Slivered Almonds"=>22.88,
        "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9}

      first_order = Grocery::Order.all[0]

      first_order.id.must_be_kind_of Integer
      first_order.id.must_equal expected_first_order_id


      first_order.products.must_be_kind_of Hash
      first_order.products.must_equal expected_first_order_products

    end

    it "Returns accurate information about the last order" do
      expected_last_order_id = 100
      # TODO: What happens this if this changes??
      expected_last_order_products = {"Allspice"=>64.74, "Bran"=>14.72,
        "UnbleachedFlour"=>80.59}

      last_order = Grocery::Order.all.last

      last_order.id.must_be_kind_of Integer
      last_order.id.must_equal expected_last_order_id


      last_order.products.must_be_kind_of Hash
      last_order.products.must_equal expected_last_order_products
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # expected_first_order_id = 1
      # expected_first_order_products = {"Slivered Almonds"=>22.88,
      #   "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9}

      # first_order = Grocery::Order.find(1)

      first_order = Grocery::Order.find(1)
      expected_first_order = Grocery::Order.all[0]



      first_order.must_be_kind_of Grocery::Order
      expected_first_order.must_be_kind_of Grocery::Order

      first_order.must_respond_to :id
      first_order.id.must_be_kind_of Integer
      # first_order.id.must_equal expected_first_order_id
      first_order.id.must_equal expected_first_order.id

      first_order.must_respond_to :products
      first_order.products.must_be_kind_of Hash
      first_order.products.must_equal expected_first_order.products


      first_order.must_equal expected_first_order
      # first_order.must_respond_to :id
      # first_order.id.must_be_kind_of Integer
      # # first_order.id.must_equal expected_first_order_id
      # first_order.id.must_equal expected_first_order.id
      #
      # first_order.must_respond_to :products
      # first_order.products.must_be_kind_of Hash
      # first_order.products.must_equal expected_first_order.products
      # first_order.products.must_equal expected_first_order_products

    end

    it "Can find the last order from the CSV" do
      expected_last_order_id = 100
      # TODO: What happens this if this changes??
      expected_last_order_products = {"Allspice"=>64.74, "Bran"=>14.72,
        "UnbleachedFlour"=>80.59}

      last_order = Grocery::Order.find(expected_last_order_id)

      last_order.must_respond_to :id
      last_order.id.must_be_kind_of Integer
      last_order.id.must_equal expected_last_order_id

      last_order.must_respond_to :products
      last_order.products.must_be_kind_of Hash
      last_order.products.must_equal expected_last_order_products
    end

    it "Return nil for an order that doesn't exist" do
      not_found = Grocery::Order.find("foo")
      assert_nil not_found

    end

  end
end
