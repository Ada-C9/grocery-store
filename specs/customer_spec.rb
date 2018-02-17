require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'

Minitest::Reporters.use!

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 542
      email = ""
      address = []

      customer = Grocery::Customer.new(id, email, address)

      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer
      customer.email.must_be_kind_of String
      customer.address.must_be_kind_of Array
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      array_of_customers = Grocery::Customer.all

      array_of_customers.must_be_kind_of Array
      array_of_customers.length.must_equal 35
    end

    it "Returns accurate information about the first customer" do
      array_of_customers = Grocery::Customer.all
      first_customer_id = array_of_customers[0][0]
      first_customer_state = array_of_customers[0][2][2]

      first_customer_id.must_equal 1
      first_customer_state.must_equal "LA"
    end

    it "Returns accurate information about the last customer" do
      array_of_customers = Grocery::Customer.all
      last_customer_id = array_of_customers[-1][0]
      last_customer_email = array_of_customers[-1][1]

      last_customer_id.must_equal 35
      last_customer_email.must_equal "rogers_koelpin@oconnell.org"
    end
  end
end

xdescribe "Customer.find" do
  it "Can find the first customer from the CSV" do
    # TODO: Your test code here!
  end

  it "Can find the last customer from the CSV" do
    # TODO: Your test code here!
  end

  it "Raises an error for a customer that doesn't exist" do
    # TODO: Your test code here!
  end
end
