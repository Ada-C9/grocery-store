require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'
require_relative '../lib/order'
require_relative '../lib/customer'

describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do

      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      online_order.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      online_order.customer.must_be_kind_of Grocery::Customer
    end

    it "Can access the online order status" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      online_order.status.must_equal :complete
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      sum = products.values.inject(0, :+)
      cents_total_fee = (sum + (sum * 0.075))*100.round + 1000

      total_with_money = online_order.total
      total_with_money.must_equal Money.new(cents_total_fee, "USD")
    end

    it "Doesn't add a shipping fee if there are no products" do
      products = {}
      customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", {:street=>"71596 Eden Route", :city=>"Connellymouth", :state=>"LA", :zip_code=>"98872-9105"})

      online_order = Grocery::OnlineOrder.new(1325, products, customer, :complete)

      total_with_money = online_order.total
      total_with_money.must_equal Money.new(0, "USD")
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      # TODO: Your test code here!
    end

    it "Permits action for pending and paid satuses" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
    end

    it "Returns accurate information about the first online order" do
      # TODO: Your test code here!
    end

    it "Returns accurate information about the last online order" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an online order that doesn't exist" do
      # TODO: Your test code here!
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end

    it "Raises an error if the customer does not exist" do
      # TODO: Your test code here!
    end

    it "Returns an empty array if the customer has no orders" do
      # TODO: Your test code here!
    end
  end
end
