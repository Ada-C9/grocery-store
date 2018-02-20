require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'


describe "Customer" do

  id = 9999
  email = "brittany.jones@gmail.com"
  delivery_address = "8903 emerson place, Everett, WA 98208"

  new_customer = Grocery::Customer.new(id,email,delivery_address)

  describe "#initialize" do
    it "Takes an ID, email and address info" do

      new_customer.must_respond_to :id
      new_customer.id.must_equal 9999
      new_customer.id.must_be_kind_of Integer

      new_customer.must_respond_to :email
      new_customer.email.must_equal "brittany.jones@gmail.com"

      new_customer.must_respond_to :delivery_address
      new_customer.delivery_address.must_equal "8903 emerson place, Everett, WA 98208"
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      list = Grocery::Customer.all
      list.must_be_kind_of Array
      list[0].must_be_kind_of Grocery::Customer
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      result = Grocery::Customer.find(34)
      result.must_be_kind_of Grocery::Customer
      result.id.must_equal 34
    end

    it "Can find the last customer from the CSV" do
      result = Grocery::Customer.find(35)
      result.must_be_kind_of Grocery::Customer
      result.id.must_equal 35
    end

    it "Returns nil for a customer that doesn't exist" do
      result = Grocery::Customer.find(456)
      result.must_be_nil
    end
  end
end
