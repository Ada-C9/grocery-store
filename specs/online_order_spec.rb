require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/order'
require_relative '../lib/online_order'


# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order
      #Instatiate your OnlineOrder here
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1,products,3)

      online_order.must_be_kind_of Grocery::Order
    end

    # it "Can access Customer object" do
    #   # TODO: Your test code here!
    # end

    it "Can access the online order status" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1,products,3)

      online_order.order_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      online_order = Grocery::OnlineOrder.new(1,products,3)

      online_order.total.must_equal 15.36
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      online_order = Grocery::OnlineOrder.new(2,products,4)

      online_order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      products1 = { "banana" => 1.99, "cracker" => 3.00 }
      products2 = { "Slivered Almonds"=> 22.88, "Wholewheat flour"=> 1.93 }
      products3 = { "Allspice"=> 64.74, "Bran"=> 14.72 , "UnbleachedFlour"=> 80.59 }
      online_order1 = Grocery::OnlineOrder.new(1,products1,1, :processing)
      online_order2 = Grocery::OnlineOrder.new(2,products2,2, :shipped)
      online_order3 = Grocery::OnlineOrder.new(3,products3,3, :completed)

      online_order1.add_product("salad",4.99).must_be_nil
      online_order2.add_product("turkey",4.99).must_be_nil
      online_order3.add_product("gravy",4.99).must_be_nil
    end

    it "Permits action for pending and paid statuses" do
      products1 = { "banana" => 1.99, "cracker" => 3.00 }
      products2 = { "Slivered Almonds"=> 22.88, "Wholewheat flour"=> 1.93 }
      online_order1 = Grocery::OnlineOrder.new(1,products1,1, :pending)
      online_order2 = Grocery::OnlineOrder.new(2,products2,2, :paid)

      online_order1.add_product("turkey",7.50).must_be_kind_of TrueClass
      online_order2.add_product("Slivered Almonds", 22.88).must_be_kind_of FalseClass
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
      Grocery::OnlineOrder.all[0].must_be_kind_of Grocery::OnlineOrder
    end

    it "Returns accurate information about the first online order" do
      product_list = {"Lobster"=>"17.18", "Annatto seed"=>"58.38", "Camomile"=>"83.21"}
      Grocery::OnlineOrder.all.first.id.must_equal 1
      Grocery::OnlineOrder.all.first.products.must_equal product_list
      Grocery::OnlineOrder.all.first.customer_id.must_equal 25
      Grocery::OnlineOrder.all.first.order_status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      product_list = {"Amaranth"=>"83.81", "Smoked Trout"=>"70.6", "Cheddar"=>"5.63"}
      Grocery::OnlineOrder.all.last.id.must_equal 100
      Grocery::OnlineOrder.all.last.products.must_equal product_list
      Grocery::OnlineOrder.all.last.customer_id.must_equal 20
      Grocery::OnlineOrder.all.last.order_status.must_equal :pending
    end
  end#end self.all method tests

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      Grocery::OnlineOrder.find(1).must_be_kind_of Grocery::OnlineOrder
    end

    it "Raises an error for an online order that doesn't exist" do
      Grocery::OnlineOrder.find(190).must_equal nil
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      Grocery::OnlineOrder.find_by_customer(25).length.must_equal 6
      Grocery::OnlineOrder.find_by_customer(25).must_be_kind_of Array

    end

    it "Raises an error if the customer does not exist" do
      Grocery::OnlineOrder.find_by_customer(32409).must_be_nil
    end

  #   xit "Returns an empty array if the customer has no orders" do
  #   end
  end
end
