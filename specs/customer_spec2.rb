require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/skip_dsl'

require_relative '../lib/customer2'

describe "Customer" do
  # describe "#initialize" do
  #   id = 42
  #   email = "adalovelace.gmail.com"
  #   address = {street: "42 Baker Street", city: "Seattle", state: "WA",
  #     zip_code: "98101-1820"}
  #
  #   test_customer = GroceryTwo::CustomerTwo.new(id, email, address)

  describe "#initialize" do
      # id = 42
      # email = "adalovelace.gmail.com"
      # address = {street: "42 Baker Street", city: "Seattle", state: "WA",
      #   zip_code: "98101-1820"}
      #
      # test_customer = GroceryTwo::CustomerTwo.new(id, email, address)

      id = rand(50..999)
      email = "adalovelace.gmail.com"
      street = "42 Baker Street"

      test_customer = GroceryTwo::NewCustomerTwo.new({id: id, email: "adalovelace.gmail.com",
        street: street, city: "Seattle", state: "WA", zip_code: "98101-1820"})
      it "Takes an ID, email and address info" do

      test_customer.must_respond_to :id
      test_customer.id.must_equal id
      test_customer.id.must_be_kind_of Integer

      test_customer.must_respond_to :email
      test_customer.email.must_equal email
      test_customer.email.must_be_kind_of String

      test_customer.must_respond_to :street
      test_customer.street.must_equal street
      test_customer.street.must_be_kind_of String
    end

    it "Updates all to include new customer" do
      test_customer.must_equal GroceryTwo::CustomerTwo.find(id)
    end
  end

  describe "Customer.all" do
    # expected_first_id = 1
    # expected_first_email = "leonard.rogahn@hagenes.org"
    # expected_first_address = {street: "71596 Eden Route", city: "Connellymouth",
    #   state: "LA",zip_code: "98872-9105"}
    #
    # expected_last_id = 35
    # expected_last_email = "rogers_koelpin@oconnell.org"
    # expected_last_address = {street: "7513 Kaylee Summit", city: "Uptonhaven",
    #   state: "DE",zip_code: "64529-2614"}

    it "Returns an array of all customers" do
      array_of_all_customers = GroceryTwo::CustomerTwo.all

      array_of_all_customers.must_be_kind_of Array

      assert array_of_all_customers.all? { |customer| customer.class ==
        GroceryTwo::CustomerTwo || customer.class ==
          GroceryTwo::NewCustomerTwo}

      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct TODO: do we need to do this?
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end

    it "Returns accurate information about the first order" do
      expected_first_id = 1
      expected_first_email = "leonard.rogahn@hagenes.org"
      expected_first_street = "71596 Eden Route"

      # TODO: What happens this if this changes??
      first_customer = GroceryTwo::CustomerTwo.all.first

      first_customer.must_respond_to :id
      first_customer.id.must_be_kind_of Integer
      first_customer.id.must_equal expected_first_id

      first_customer.must_respond_to :email
      first_customer.email.must_be_kind_of String
      first_customer.email.must_equal expected_first_email

      first_customer.must_respond_to :street
      first_customer.street.must_be_kind_of String
      first_customer.street.must_equal expected_first_street

    end

    it "Returns accurate information about the last order" do
      expected_last_id = rand(999...99999)
      expected_last_email = "lasssst.gmail.com"
      expected_last_street = "999 last Street"

      GroceryTwo::NewCustomerTwo.new({id: expected_last_id, email: expected_last_email,
        street: expected_last_street, city: "LAST", state: "LP", zip_code: "98101-1820"})


      # TODO: What happens this if this changes??
      last_customer = GroceryTwo::CustomerTwo.all.last

      last_customer.must_respond_to :id
      last_customer.id.must_be_kind_of Integer
      last_customer.id.must_equal expected_last_id

      last_customer.must_respond_to :email
      last_customer.email.must_be_kind_of String
      last_customer.email.must_equal expected_last_email

      last_customer.must_respond_to :street
      last_customer.street.must_be_kind_of String
      last_customer.street.must_equal expected_last_street
    end
  end

  describe "Customer.find" do


    it "Can find the first customer from the CSV" do
      expected_first_id = 1
      expected_first_email = "leonard.rogahn@hagenes.org"
      expected_first_street = "71596 Eden Route"

      first_customer_for_find = GroceryTwo::CustomerTwo.find(expected_first_id)

      first_customer_for_find.must_respond_to :id
      first_customer_for_find.id.must_be_kind_of Integer
      first_customer_for_find.id.must_equal expected_first_id

      first_customer_for_find.must_respond_to :email
      first_customer_for_find.email.must_be_kind_of String
      first_customer_for_find.email.must_equal expected_first_email

      first_customer_for_find.must_respond_to :street
      first_customer_for_find.street.must_be_kind_of String
      first_customer_for_find.street.must_equal expected_first_street

    end

    it "Can find the last customer from the CSV" do
      expected_last_id = rand(999...99999)
      expected_last_email = "llllllllasssst.gmail.com"
      expected_last_street = "999 last with finds"

      GroceryTwo::NewCustomerTwo.new({id: expected_last_id, email: expected_last_email,
        street: expected_last_street, city: "LAST", state: "LP", zip_code: "98101-1820"})


      last_customer_for_find = GroceryTwo::NewCustomerTwo.find(expected_last_id)

      last_customer_for_find.must_respond_to :id
      last_customer_for_find.id.must_be_kind_of Integer
      last_customer_for_find.id.must_equal expected_last_id

      last_customer_for_find.must_respond_to :email
      last_customer_for_find.email.must_be_kind_of String
      last_customer_for_find.email.must_equal expected_last_email

      last_customer_for_find.must_respond_to :street
      last_customer_for_find.street.must_be_kind_of String
      last_customer_for_find.street.must_equal expected_last_street
    end

    it "Raises an error for a customer that doesn't exist" do
      invalid_customer_number = GroceryTwo::CustomerTwo.find("bar")
      assert_nil invalid_customer_number
    end

  end
end
