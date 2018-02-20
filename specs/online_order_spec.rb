require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/online_order'



describe "OnlineOrder" do
  describe "#initialize" do
    it "Is a kind of Order" do
      online_order = Grocery::OnlineOrder.new(3, {"vainilla" => 3.45 }, 55,  :pending)
      online_order.must_be_kind_of Grocery::Order

    end

    it "Can access Customer object" do
      online_order = Grocery::OnlineOrder.new(3, {"vainilla" => 3.45 }, 35,  :pending)
      online_order.customer.id.must_equal  Grocery::Customer.find(35).id
      online_order.customer.email.must_equal Grocery::Customer.find(35).email
      online_order.customer.delivery_address.must_equal Grocery::Customer.find(35).delivery_address
    end

    it "Can access the online order status" do
      online_order = Grocery::OnlineOrder.new(3, {"vainilla" => 3.45 }, 55,  :pending)
      online_order.fulfillment_status.must_equal :pending
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      online_order = Grocery::OnlineOrder.new(3, {"vainilla" => 3.45 }, 55,  :pending)
      online_order.total.must_equal (3.71 + 10)
    end

    it "Doesn't add a shipping fee if there are no products" do
      online_order = Grocery::OnlineOrder.new(3, { }, 55,  :pending)
      online_order.total.must_equal (0)
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      online_order = Grocery::OnlineOrder.new(3, { }, 55,  :complete )
      proc {online_order.add_product}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      online_order = Grocery::OnlineOrder.new(3, {"vainilla" => 3.45 }, 55,  :pending)
      online_order.add_product("sandwich", 4.25)

      online_order.products.include?("sandwich").must_equal true
    end
  end

  describe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      Grocery::OnlineOrder.all.must_be_kind_of Array
    end

    it "Returns accurate information about the first online order" do
      Grocery::OnlineOrder.all.first.products.must_equal ({"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21})
      Grocery::OnlineOrder.all.first.online_order_id.must_equal 1
      Grocery::OnlineOrder.all.first.fulfillment_status.must_equal :complete

    end

    it "Returns accurate information about the last online order" do

      Grocery::OnlineOrder.all.last.products.must_equal ({"Amaranth"=>83.81, "Smoked Trout"=>70.6, "Cheddar"=>5.63})
      Grocery::OnlineOrder.all.last.online_order_id.must_equal 100
      Grocery::OnlineOrder.all.last.fulfillment_status.must_equal :pending
    end
  end

  describe "OnlineOrder.find" do
    it "Will find an online order from the CSV" do
      online_order = Grocery::OnlineOrder.find(99)
      online_order.online_order_id.must_equal 99
      online_order.products.must_equal ({ "White rice"=>66.16, "Besan"=>19.33, "Strawberries"=>61.29, "Taleggio cheese"=>68.45})
    end

    it "Raises an error for an online order that doesn't exist" do

      proc {Grocery::OnlineOrder.find(120)}.must_raise ArgumentError
    end
  end

  describe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do

      number_of_orders = 0
      orderlist = Grocery::OnlineOrder.all
      orderlist.each do |order|
        if order.id == 2
          number_of_orders += 1
        end
      end
      Grocery::OnlineOrder.find_by_customer(2).must_be_kind_of Array
      Grocery::OnlineOrder.find_by_customer(2).length.must_equal number_of_orders
    end

    it "Raises an error if the customer does not exist" do
      proc {Grocery::OnlineOrder.find_by_customer(365)}.must_raise ArgumentError
    end

    it "Returns an empty array if the customer has no orders" do
      Grocery::OnlineOrder.find_by_customer(16). must_equal []

    end
  end
end
