require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'

require 'csv'
require 'awesome_print'


describe "Order Wave 1" do
  xdescribe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      products = {'olives': 3.30, 'bread': 4.45}
      order = Grocery::Order.new(id, products)

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 2

    end
  end

  xdescribe "#total" do
    it "Returns the total from the collection of products" do
      #arrange
      products = { "banana" => 1.99, "cracker" => 3.00}
      order = Grocery::Order.new(1337, products)

      #act
      sum = products.values.inject(0, :+)
      expected_total = sum + ((sum )* 0.075).round(2)

      #assert
      order.total.must_equal expected_total
    end

    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})

      order.total.must_equal 0
    end
  end

  xdescribe "#add_product" do
    it "Increases the number of products" do
      products = {"banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      #returns true or false
      order.products.count == expected_count
    end

     #tests remove product method
    xdescribe "#remove_product" do
      it "Decreases the number of products" do
        #arrange
        products = {"banana" => 1.99, "cracker" => 3.00}
        before_count = products.count
        order = Grocery::Order.new(1337, products)
        #act
        order.remove_product("Slivered Almonds")
        expected_count = before_count - 1
        #assert
        #returns true or false
         order.products.count == expected_count
      end
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
xdescribe "Order Wave 2" do


  describe "Order.all" do
    it "Returns an array of all orders" do
      # TODO: Your test code here!
      #arrange
       # not neccessary for class methods
      #act
      result = Grocery::Order.all
      #assert
      #returns an array
      result.must_be_kind_of Array
      #returns the right number of elements
      #more assertions checking other thigns
      #each element is an instance and has right number of orders
    end

    it "Returns accurate information about the first order" do
      # TODO: Your test code here!
      #act
      first_order = CSV.open('support/orders.csv', 'r') { |csv| csv.first }
      #assert
      first_order == (Grocery::Order.all).first
    end

    it "Returns accurate information about the last order" do
      # TODO: Your test code here!
      #act
      last_order = CSV.open('support/orders.csv', 'r').to_a

      #assert - checks last element in both arrays
      last_order[-1] == (Grocery::Order.all)[-1]
    end
  end

  xdescribe "Order.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!
      #act
      first_order = CSV.open('support/orders.csv', 'r').to_a[0]
      #assert
      first_order == Grocery::Order.find(1)

    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
      #act
      last_order = CSV.open('support/orders.csv', 'r').to_a[-1]
      #assert
      last_order == Grocery::Order.find(-1)
    end

    it "Returns nil for an order that does not exist" do
      # TODO: Your test code here!
      #raiseargumenterror
      #act
      #order ='a'
      order = 1000000000000
      #order = 0

      #assert
      Grocery::Order.find(order).must_be_nil

    end
  end
end
