require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/order'
require 'csv'

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
  CSV.open('sample.csv', 'w+') do |csv|
    csv << ["1","Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"]
    csv << ["2","Albacore Tuna:36.92;Capers:97.99;Sultanas:2.82;Koshihikari rice:7.55"]
    csv << ["3","Lentils:7.17"]
    csv << ["4","Hiramasa Kingfish:78.37;Oatmeal:10.41;Mahi mahi:35.95;Bean Sprouts:16.5"]
  end

  describe "Order.all" do
    orders = Grocery::Order.all('sample.csv')

    it "Returns an array of all orders" do
      orders.must_be_kind_of Array
      orders.length.must_equal 4
      orders.each do |order|
        order.must_be_instance_of Grocery::Order
      end
    end

    it "Returns accurate information about the first order" do
      orders.first.id.must_be_kind_of Integer
      orders.first.id.must_equal 1
      orders.first.products.must_be_kind_of Hash
      orders.first.products.must_equal ({"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})
      orders.first.total.must_equal 107.19
    end

    it "Returns accurate information about the last order" do
      orders.last.id.must_be_kind_of Integer
      orders.last.id.must_equal 4
      orders.last.products.must_be_kind_of Hash
      orders.last.products.must_equal ({"Hiramasa Kingfish"=>78.37, "Oatmeal"=>10.41, "Mahi mahi"=>35.95, "Bean Sprouts"=>16.5})
      orders.last.total.must_equal 151.82
    end
  end

  describe "Order.find" do
    it "Can find the first order from the CSV" do
      order = Grocery::Order.find(1,'sample.csv')

      order.must_be_instance_of Grocery::Order
      order.id.must_equal 1
      order.products.must_equal ({"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})
    end

    it "Can find the last order from the CSV" do
       order = Grocery::Order.find(4,'sample.csv')

       order.must_be_instance_of Grocery::Order
       order.id.must_equal 4
       order.products.must_equal ({"Hiramasa Kingfish"=>78.37, "Oatmeal"=>10.41, "Mahi mahi"=>35.95, "Bean Sprouts"=>16.5})
     end

    it "Return nil for an order that doesn't exist" do
      Grocery::Order.find(5,'sample.csv').must_be_nil
    end
  end
end
