require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
Minitest::Reporters.use!


#_______________ WAVE 1 _______________

describe "Order Wave 1" do

  #############################################################################################
  # INITIALIZES Order:

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

  #############################################################################################
  # CALCULATES TOTAL OF ORDER:

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

  #############################################################################################
  # REMOVES PRODUCT OF ORDER:

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

  #############################################################################################
  # ADDS PRODUCT TO ORDER:

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


#_______________ WAVE 2_______________

describe "Order Wave 2" do

  #############################################################################################
  # READS FILE OF ALL ORDERS AND ADDS THEM:

  describe "Order.all" do
    it "Returns an array of all orders" do

      orders = CSV.read('support/orders.csv', 'r')

      Grocery::Order.all.length.must_equal orders.length

      Grocery::Order.all.must_be_kind_of Array

    end

    it "Returns accurate information about the first order" do

        # Create order #1:
      file_first_order = Grocery::Order.new(1, {"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})

      # create array of the first_order:
      first_order = Grocery::Order.all[0]

      # evaluate:
      file_first_order.id.must_equal first_order.id
      file_first_order.products.must_equal first_order.products
    end

    it "Returns accurate information about the last order" do
      # Create order #1:
    file_last_order = Grocery::Order.new(100, {"Allspice"=>64.74, "Bran"=>14.72, "UnbleachedFlour"=>80.59})

    # create array of the first_order:
    last_order = Grocery::Order.all[99]

    # evaluate:
    file_last_order.id.must_equal last_order.id
    file_last_order.products.must_equal last_order.products
    end
  end

  #############################################################################################
  # FINDS ORDER:

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      # Order #1 on file:
      # orders = CSV.read('support/orders.csv', 'r')[0][0]

      # Create all orders on Grocery module and search for the order #1:
      orders = Grocery::Order.all
      find =  Grocery::Order.find(1)

      orders[0].must_equal find
    end

    it "Can find the last order from the CSV" do
      # Order #1 on file:
      order = CSV.read('support/orders.csv', 'r')[99][0].to_i

      # Create all orders on Grocery module and search for the order #100:
      Grocery::Order.all[0]
      find =  Grocery::Order.find(100)

      order.must_equal find.id
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
