require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 1234
      email = "rhubarbra@dogworld.com"
      address = "1234 Treat lane, Seattle WA 98103"
      roobear = Grocery::Customer.new(id, email, address)

      roobear.must_respond_to :id
      roobear.id.must_equal id
      roobear.id.must_be_kind_of Integer

      roobear.must_respond_to :email
      roobear.email.must_equal email

      roobear.must_respond_to :address
      roobear.address.must_equal address

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

  describe "Customer.find" do
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
