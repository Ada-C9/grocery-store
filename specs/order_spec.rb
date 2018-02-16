require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/order'

xdescribe "Order Wave 1" do
  xdescribe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end # describe initialize

  xdescribe "#total" do
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
  end # describe total

  xdescribe "#add_product" do
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
  end # describe add_product

  xdescribe "#remove_product" do
    it "Decreases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.remove_product("cracker")
      expected_count = before_count - 1
      order.products.count.must_equal expected_count
    end

    it "Removes the item from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      order = Grocery::Order.new(1337, products)

      order.remove_product("cracker")
      order.products.include?("cracker").must_equal false
    end

    it "Returns false if the product isn't already present" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.remove_product("cheese")
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product wasn't already present" do
      products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25 }
      order = Grocery::Order.new(1337, products)

      result = order.remove_product("cracker")
      result.must_equal true
    end
  end # describe remove_product

end # describe order wave 1


# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Order Wave 2" do
  xdescribe "Order.all" do
    it "Returns an array of all orders" do
      # TODO: Your test code here!
      # arrange
      # get num rows in csv file
      # orders_row_count = orders.csv.readlines.size
      orders_row_count = 0
      CSV.open("support/orders.csv", "r").each do |order|
        orders_row_count += 1
      end

      # check orders_row_count works
      # orders_row_count.must_equal 100

      # act
      # call .all class method on Orders
      # get length of array that was returned
      orders_array = Grocery::Order.all
      orders_array_length = orders_array.length

      #assert
      # check that length of array equals num rows in csv file
      orders_array_length.must_equal orders_row_count
    end

    it "Returns accurate information about the first order" do
      # TODO: Your test code here!
      # arrange
      first_order_id = "1"
      first_order_details = {"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9}

      # act
      first_order = Grocery::Order.all[0]

      # assert
      first_order.id.must_equal first_order_id
      first_order.products.must_equal first_order_details

    end

    it "Returns accurate information about the last order" do
      # TODO: Your test code here!
      # arrange
      last_order_id = "100"
      last_order_details = {"Allspice"=>64.74, "Bran"=>14.72, "UnbleachedFlour"=>80.59}

      # act
      last_order = Grocery::Order.all.last

      # assert
      last_order.id.must_equal last_order_id
      last_order.products.must_equal last_order_details
    end
  end # describe order.all

  xdescribe "Order.find" do
    it "Can find the first order from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last order from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an order that doesn't exist" do
      # TODO: Your test code here!
    end
  end # describe order find

end # describe order wave 2
