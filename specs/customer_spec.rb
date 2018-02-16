require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      # arrange
      id = 50
      email = "thebatintheman@gmail.com"
      address = "200 Cave St., Baton Rouge, Louisiana, 65980"

      # act
      customer = Grocery::Customer.new(id, email, address)

      # assert
      customer.must_respond_to :id
      customer.id.must_be_kind_of Integer
      customer.id.must_equal id
      customer.must_respond_to :email
      customer.email.must_be_kind_of String
      customer.email.must_equal email
      customer.must_respond_to :address
      customer.address.must_be_kind_of String
      customer.address.must_equal address
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
