require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'minitest/reporters'
require_relative '../lib/customer'

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do

       an_order = Grocery::Customer.new('36', 'maggie@mutts.org', '2000 Fire Hydrant Way, Seattle, WA 98115')

      ap an_order
      an_order.customer_id.must_equal '36'

    end
  end

  describe "Customer.all" do
    it "Returns an array of all customers" do
      all_customers = Grocery::Customer.all
  #   Customer.all returns an array
      all_customers.must_be_kind_of Array
  #   - The number of orders is correct
      all_customers.length.must_equal 35

      # Useful checks might include:
      #   - Everything in the array is a Customer
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      all_customers[0].email.must_equal 'leonard.rogahn@hagenes.org'
      all_customers[0].customer_id.must_equal '1'
      all_customers[34].email.must_equal 'rogers_koelpin@oconnell.org'
      all_customers[34].customer_id.must_equal '35'
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      first_customer = Grocery::Customer.find('1')
      first_customer.customer_id.must_equal '1'
      first_customer.email.must_equal 'leonard.rogahn@hagenes.org'
    end

    it "Can find the last customer from the CSV" do
      last_customer = Grocery::Customer.find('35')
      last_customer.email.must_equal 'rogers_koelpin@oconnell.org'
      last_customer.customer_id.must_equal '35'
    end

    it "Raises an error for a customer that doesn't exist" do
      proc { Grocery::Customer.find("36") }.must_raise NoMethodError
    end
  end
end
