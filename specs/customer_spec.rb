require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative "../lib/customer"
require "csv"

# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
    object =  Grocery::Customer.new(35, "winirarrazaval@gmail.com", "7622 SE 22nd St" )
    object.id.must_equal 35
    object.email.must_equal "winirarrazaval@gmail.com"
    object.delivery_address.must_equal "7622 SE 22nd St"
    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      # Useful checks might include:ls
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
