require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # Arrange
      id = 1
      email = "ada@ada.org"
      address = "1215 4th Ave #1050, Seattle, WA 98161"
      # Action
      customer = Grocery::Customer.new(id, email, address)
      # Assertion
      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      customer.email.must_equal email

      customer.must_respond_to :address
      customer.address.must_equal address
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # Action
      customers = Grocery::Customer.all
      # Assertion
      customers.class.must_equal Array
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # Arrange
      id = 1
      # Action
      first_customer = Grocery::Customer.find(id)
      # Assertion
      first_customer.id.must_equal id
    end

    it "Can find the last customer from the CSV" do
      # Arrange
      id = 35
      # Action
      last_customer = Grocery::Customer.find(id)
      # Assertion
      last_customer.id.must_equal id
    end

    it "Raises an error for a customer that doesn't exist" do
      # Arrange
      id = 111
      # Action
      result = Grocery::Customer.find(id)
      # Assertion
      result.must_equal ArgumentError
    end
  end
end
