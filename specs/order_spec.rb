require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
# Minitest::Test.make_my_diffs_pretty!
require 'minitest/skip_dsl'

require_relative '../lib/order'


# Provides tests for initializing Order and the total and add_product methods.
describe "Order Wave 1" do

  # Creates a generic, normal instance of Order to run tests on
  before do
    @normal_order_products = { "banana" => 1.99, "cracker" => 3.00 }
    @normal_order_id = 1820
    @normal_order = Grocery::Order.new(@normal_order_id, @normal_order_products)
  end

  # Tests if a new Order is initialized with attributes of 'id' and 'products'
  describe "#initialize" do
    # The id and products of Order must match the values it was given
    it "Takes an ID and collection of products" do

      # Tests class on normal order
      @normal_order.must_be_kind_of Grocery::Order

      # Tests id on normal order
      @normal_order.must_respond_to :id # must have attr_reader for id
      @normal_order.id.must_equal @normal_order_id
      @normal_order.id.must_be_kind_of Integer

      # Tests products on normal order
      @normal_order.must_respond_to :products # must have attr_reader for products
      @normal_order.products.must_equal @normal_order_products
      @normal_order.products.size.must_equal @normal_order_products.size
    end
  end


  # Tests if total returns the total cost of the order, including tax and
  # rounded to two decimal places.
  describe "#total" do
    it "Returns the total from the collection of products" do
      sum = @normal_order.products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)

      @normal_order.total.must_equal expected_total # Must be total + tax and rounded
    end

    # Tests if total returns a the total cost of the order, including tax and
    # rounded to two decimal places.
    it "Returns a total of zero if there are no products" do
      empty_order = Grocery::Order.new(1235, {})
      empty_order.total.must_equal 0.0
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


xdescribe "Order Wave 2" do
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
      assert_nil Grocery::Order.find("foo")
    end

  end
end

# # Destroys the generic, normal instance of Order in case it's existence causes
# # problems in other tests.
# after do
#   @normal_order = nil
# end
