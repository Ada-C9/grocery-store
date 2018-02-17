require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

Minitest::Reporters.use!

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # arrange
      id = 1234
      email = "kathryn@lindcasper.net"
      address = "995 Harris Track,Ryanborough,HI,67820"
      # act
      customer =Grocery::Customer.new(id, email, address)
      # assert
      customer.must_respond_to :id
      customer.id.must_equal id
      customer.id.must_be_kind_of Integer

      customer.must_respond_to :email
      # asserts that the email is a valid email address (found by searching 'regex for email ruby')
      assert_match(/[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+/, customer.email)
      # customer.email.must_include "@"

      customer.must_respond_to :address
      # asserts that a state id exsists in the address string
      assert_match(/\b[A-Z]{2}/, customer.address)
    end
  end

  xdescribe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
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
end
