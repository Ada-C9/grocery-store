require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer.rb'

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do

  id = 3452
  email = "karinna@gmail.com"
  delivery_address = "227 Boyston Ave E, Seattle, WA 98102"

  new_customer = Grocery::Customer.new(id,email,delivery_address)

  describe "#initialize" do
    it "Takes an ID, email and address info" do

      new_customer.must_respond_to :id
      new_customer.id.must_equal 345
      new_customer.id.must_be_kind_of Integer

      new_customer.must_respond_to :email
      new_customer.email.must_equal "karinna@gmail.com"

      new_customer.must_respond_to :delivery_address
      new_customer.delivery_address.must_equal "227 Boylston Ave E, Seattle, WA 98102"
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
      result.id.must_equal 23
    end

    it "Can find the last customer from the CSV" do
      result = Grocery::Customer.find(100)
      result.must_be_kind_of Grocery::Customer
      result.id.must_equal 100
    end

    it "Raises an error for a customer that doesn't exist" do
      result = Grocery::Customer.find(456)
      result.must_be_nil
    end
  end
end
