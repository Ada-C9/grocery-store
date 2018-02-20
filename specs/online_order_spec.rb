require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use!

# TODO: uncomment the next line once you start wave 3
 require_relative '../lib/onlineorder'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      # Check that an OnlineOrder is in fact a kind of Order

      # Instatiate your OnlineOrder here
      # online_order =
      # online_order.must_be_kind_of Grocery::Order
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route",
        :city=>"Connellymouth", :state=>"LA", :zip=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1, products, customer, :complete)


    end

    it "Can access Customer object" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org",
        {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1, products, customer, :complete)

      online_order.customer.must_be_instance_of Grocery::Customer
    end

    it "Can access the online order status" do
      # TODO: Your test code here!
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org",
        {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1, products, customer, :complete)

      online_order.status.must_equal :complete
    end
  end



  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      result = Grocery::OnlineOrder.all
      result.must_be_instance_of Array
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
      online_orders = Grocery::OnlineOrder.all
      first_order = online_orders[0]

       first_order.id.must_equal 1
       #first_order.products.must_equal "Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21
        first_order.customer.id.must_equal 25
       # first_order.status.must_equal :complete
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
      Grocery::OnlineOrder.all[-1].id.must_equal 100
      Grocery::OnlineOrder.all[-1].status.must_equal :pending
    end
  end
  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!

      Grocery::OnlineOrder.find(1).id.must_equal 1
      Grocery::OnlineOrder.find(3).status.must_equal :processing
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
      proc {Grocery::OnlineOrder.find(206)}.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!

      result = Grocery::OnlineOrder.find_by_customer(1)
      result.must_be_instance_of Array
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
      proc { Grocery::OnlineOrder.find_by_customer(50) }.must_raise ArgumentError
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
      # Manually searched for customers with no online order
      Grocery::OnlineOrder.find_by_customer(22).must_be_empty

    end
  end
end
