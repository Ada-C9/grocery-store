require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/customer'



describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

      new_customer = Grocery::Customer.new(1, "leonard.rogahn@hagenes.org", "71596 Eden Route, Connellymouth, LA, 98872-9105")

      new_customer.must_respond_to :costumer_id
      new_customer.costumer_id.must_equal 1
      new_customer.costumer_id.must_be_kind_of Integer

      new_customer.must_respond_to :email
      new_customer.email.must_equal "leonard.rogahn@hagenes.org"

      new_customer.must_respond_to :address
      new_customer.address.must_equal "71596 Eden Route, Connellymouth, LA, 98872-9105"
    end
  end

  describe "Customer.all" do
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
