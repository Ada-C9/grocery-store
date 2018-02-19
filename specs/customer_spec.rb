require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3
require_relative '../lib/customer'

Minitest::Reporters.use!

describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      # TODO: Your test code here!
      test_id = 123
      test_email = "test@email.com"
      test_address = "test address"

      customer = Grocery::Customer.new(test_id, test_email, test_address)

      customer.must_respond_to :id
      customer.must_respond_to :email
      customer.must_respond_to :address
      customer.id.must_equal test_id
      customer.email.must_equal test_email
      customer.address.must_equal test_address
    end
  end

  describe "Customer.all" do
    before do
      @all_customers = Grocery::Customer.all
    end
    it "Returns an array of all customers" do
      # TODO: Your test code here!
      #   - The number of orders is correct
      length = @all_customers.length
      length.must_equal 35
      @all_customers.must_be_instance_of Array
    end

    it "Returns correct info for the first and last" do
      # The ID, email address of the first and last
      #   customer match what's in the CSV file
      first_customer = @all_customers[0]
      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      first_customer.address.must_equal "71596 Eden Route, Connellymouth, LA 98872-9105"

      last_customer = @all_customers[34]
      last_customer.id.must_equal 35
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
      last_customer.address.must_equal "7513 Kaylee Summit, Uptonhaven, DE 64529-2614"
    end

    it "returns array of Customer class objects" do
      # Everything in the array is a Customer
      @all_customers.each do |customer|
        customer.must_be_kind_of Grocery::Customer
      end
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      # TODO: Your test code here!
      first_customer = Grocery::Customer.find(1)
      first_customer.id.must_equal 1
      first_customer.email.must_equal "leonard.rogahn@hagenes.org"
      first_customer.address.must_equal "71596 Eden Route, Connellymouth, LA 98872-9105"
    end

    it "Can find the last customer from the CSV" do
      # TODO: Your test code here!
      last_customer = Grocery::Customer.find(35)
      last_customer.id.must_equal 35
      last_customer.email.must_equal "rogers_koelpin@oconnell.org"
      last_customer.address.must_equal "7513 Kaylee Summit, Uptonhaven, DE 64529-2614"
    end

    it "Raises an error for a customer that doesn't exist" do
      # TODO: Your test code here!
      no_such_customer = Grocery::Customer.find(36)

      assert_nil(no_such_customer, "There is no customer with that id")
    end
  end
end
