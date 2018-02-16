require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require 'awesome_print'

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
      products = {"banana" => 1.99, "cracker" => 3.00}
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
      products = {"banana" => 1.99, "cracker" => 3.00}
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = {"banana" => 1.99, "cracker" => 3.00}
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = {"banana" => 1.99, "cracker" => 3.00}

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = {"banana" => 1.99, "cracker" => 3.00}
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  describe "Order.all_orders" do
    it "Returns an array of all orders" do
      #all instances of orders (loop through)

      Grocery::Order.all_orders.must_be_kind_of Array
      Grocery::Order.all_orders.length.must_equal 100
    end

    it "Returns accurate information about the first order" do
      Grocery::Order.all_orders[0].products.class.must_equal Hash
      Grocery::Order.all_orders[0].products.length.must_equal 3
      Grocery::Order.all_orders[0].products.must_equal ({"Slivered Almonds"=>"22.88", "Wholewheat flour"=>"1.93", "Grape Seed Oil"=>"74.9"})

    end

    it "Returns accurate information about the last order" do
      Grocery::Order.all_orders.last.products.class.must_equal Hash
      Grocery::Order.all_orders.last.products.length.must_equal 3
      Grocery::Order.all_orders.last.products.must_equal ({"Allspice"=>"64.74", "Bran"=>"14.72", "UnbleachedFlour"=>"80.59"})
    end
  end

  # describe "Order.find_order" do
  #   xit "Can find the first order from the CSV" do
  #     orders = [
  #       a = [Grocery::Order.new(1111, {"banana" => 1.99, "cracker" => 3.00 })],
  #       b = [Grocery::Order.new(2222, {"apple" => 2.99, "miso" => 3.00})]]
  #
  #       orders.first.must_equal orders[0]
  #     end
  #
  #   xit "Can find the last order from the CSV" do
  #     orders = [
  #     a = [Grocery::Order.new(1111, {"banana" => 1.99, "cracker" => 3.00})],
  #     b = [Grocery::Order.new(2222, {"apple" => 2.99, "miso" => 3.00})]]
  #
  #     orders.last.must_equal orders[1]
  #
  #   end
  #
  #   xit "Raises an error for an order that doesn't exist" do
  #     orders = [
  #     a = [Grocery::Order.new(1111, {"banana" => 1.99, "cracker" => 3.00})],
  #     b = [Grocery::Order.new(2222, {"apple" => 2.99, "miso" => 3.00})]]
  #
  #     result = orders.check_order(3333)
  #     result.must_equal false
  #
  #   end
  # end
end
