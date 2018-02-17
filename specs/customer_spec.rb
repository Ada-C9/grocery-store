require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer.rb'
require 'awesome_print'

# TODO: uncomment the next line once you start wave 3


describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 309
      email = "lsky@ada.com"
      address = "123,Fourth Ave, Seattle, WA 98000"
      order = Grocery::Customer.new(id, email, address)

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :email
      order.email.must_equal "lsky@ada.com"

      order.must_respond_to :address
      order.address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      Grocery::Customer.all_customers.first.address.must_be_kind_of Array

      Grocery::Customer.all_customers.length.must_equal 35

      Grocery::Customer.all_customers.last.address.must_equal (["7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"])

      Grocery::Customer.all_customers.last.id.must_equal "35"

      Grocery::Customer.all_customers.last.email.must_equal "rogers_koelpin@oconnell.org"
    end
  end

  describe "Customer.find" do
    it "Can find a customer from the CSV" do
      Grocery::Customer.find_customer("20").id.must_equal "20"
      Grocery::Customer.find_customer("20").address.must_equal (["90842 Amani Common, Weissnatfurt, TX, 24108"])
    end

    it "Can find the first customer from the CSV" do
      Grocery::Customer.find_customer("1").id.must_equal "1"
      Grocery::Customer.find_customer("1").address.must_equal (["71596 Eden Route, Connellymouth, LA, 98872-9105"])
    end

    it "Can find the last customer from the CSV" do
      Grocery::Customer.find_customer("35").id.must_equal "35"
      Grocery::Customer.find_customer("35").address.must_equal (["7513 Kaylee Summit, Uptonhaven, DE, 64529-2614"])
    end

    it "Raises an error for a customer that doesn't exist" do
      Grocery::Customer.find_customer("50").must_equal nil
      Grocery::Customer.find_customer("0").must_equal nil
    end
  end
end
