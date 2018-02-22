require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
Minitest::Reporters.use!


xdescribe "Order Wave 1" do
  xdescribe "#initialize" do # DONE
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

  xdescribe "#total" do # DONE
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

  xdescribe "#add_product" do # DONE
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
    it "Returns an array of all orders" do # DONE
      Grocery::Order.all.must_be_kind_of Array
    end # it/do


    it "Returns accurate information about the first order" do # DONE
      Grocery::Order.all[0].id.must_equal 1
      product_in_1st = {"Slivered Almonds" => 22.88, "Wholewheat flour" => 1.93, "Grape Seed Oil" => 74.9}
      Grocery::Order.all[0].products.must_equal product_in_1st
    end # it/do

    it "Returns accurate information about the last order" do #DONE
      Grocery::Order.all[-1].id.must_equal 100
      product_last = {"Allspice" => 64.74, "Bran" => 14.72, "UnbleachedFlour" => 80.59}
      Grocery::Order.all[-1].products.must_equal product_last
    end # it/do
  end # describe "Order.all" do


  describe "Order.find" do
    it "Can find the first order from the CSV" do # DONE
      first_id = Grocery::Order.find(1)
      first_id.id.must_equal 1
    end

    it "Can find the last order from the CSV" do # DONE
      last_id = Grocery::Order.find(100)
      last_id.id.must_equal 100
    end

    it "Raises an error for an order that doesn't exist" do # DONE 
      phantom_id = Grocery::Order.find(101)
      assert_nil phantom_id
    end # it "Raises an error..." do
  end # describe "Order.find" do

end # describe "Order Wave 2" do
