require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      id = 15
      email_address = "bria_anderson@kub.io"
      delivery_address = "430 Herzog Rest,East Lonie,DE,44921"
      customer = Grocery::Customers.new(id, email_address, delivery_address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email_address
      customer.email_address.must_equal email_address
      customer.email_address.must_be_kind_of String

      customer.must_respond_to :delivery_address
      customer.delivery_address.must_equal delivery_address
      customer.delivery_address.must_be_kind_of String
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!

      array = Grocery::Customers.all
      array.must_be_instance_of Array

      Grocery::Customers.all.length.must_equal 35
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!

      Grocery::Customers.find(1).must_be_instance_of Grocery::Customers

      # The first customer in the CSV file is customer with id 1.
      first_customer_id = Grocery::Customers.all[0].id
      first_customer_id.must_equal 1

      # This tests that it matches all the information of the first customer.
      first_customer_email = Grocery::Customers.all[0].email_address
      expected_first_customer = "leonard.rogahn@hagenes.org"
      first_customer_email.must_equal expected_first_customer
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      # The last customer in the CSV file is customer with id 35.
      Grocery::Customers.find(35).must_be_instance_of Grocery::Customers

      last_customer_id = Grocery::Customers.all[-1].id
      last_customer_id.must_equal 35

      # This tests that it matches all the information of the last customer.
      last_customer_email = Grocery::Customers.all[-1].email_address
      expected_last_customer = "rogers_koelpin@oconnell.org"
      last_customer_email.must_equal expected_last_customer
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!

      # I tested with #50 which is a customer that doesn't exist.
      result = Grocery::Customers.find(50)
      result.must_be_nil
    end
  end
end
