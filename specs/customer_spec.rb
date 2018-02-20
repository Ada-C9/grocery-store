require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/skip_dsl'

require_relative '../lib/customer'








describe "Customer" do
  describe "#initialize" do
    it "Takes an ID, email and address info" do
      id = 42
      email = "adalovelace.gmail.com"
      address = {street: "42 Baker Street", city: "Seattle", state: "WA",
        zip_code: "98101-1820"}

      test_customer = Grocery::Customer.new(id, email, address)

      test_customer.must_respond_to :id
      test_customer.id.must_equal id
      test_customer.id.must_be_kind_of Integer

      test_customer.must_respond_to :email
      test_customer.email.must_equal email
      test_customer.email.must_be_kind_of String

      test_customer.must_respond_to :address
      test_customer.address.must_equal address
      test_customer.address.must_be_kind_of Hash
    end
  end

  describe "Customer.all" do

    expected_first_id = 1
    expected_first_email = "leonard.rogahn@hagenes.org"
    expected_first_address = {street: "71596 Eden Route", city: "Connellymouth",
      state: "LA",zip_code: "98872-9105"}

    expected_last_id = 35
    expected_last_email = "rogers_koelpin@oconnell.org"
    expected_last_address = {street: "7513 Kaylee Summit", city: "Uptonhaven",
      state: "DE",zip_code: "64529-2614"}

    it "Returns an array of all customers" do
      array_of_all_customers = Grocery::Customer.all

      array_of_all_customers.must_be_kind_of Array

      assert array_of_all_customers.all? { |customer| customer.class == Grocery::Customer}

      # Useful checks might include:
      #   - Customer.all returns an array
      #   - Everything in the array is a Customer
      #   - The number of orders is correct TODO: do we need to do this?
      #   - The ID, email address of the first and last
      #       customer match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end

    it "Returns accurate information about the first order" do
      # expected_first_id = 1
      # expected_first_email = "leonard.rogahn@hagenes.org"
      # expected_first_address = {street: "1596 Eden Route", city: "Connellymouth",
      #   state: "LA",zip_code: "98872-9105"}

      # TODO: What happens this if this changes??
      first_customer = Grocery::Customer.all.first

      first_customer.must_respond_to :id
      first_customer.id.must_be_kind_of Integer
      first_customer.id.must_equal expected_first_id

      first_customer.must_respond_to :email
      first_customer.email.must_be_kind_of String
      first_customer.email.must_equal expected_first_email

      first_customer.must_respond_to :address
      first_customer.address.must_be_kind_of Hash
      first_customer.address.must_equal expected_first_address

    end

    it "Returns accurate information about the last order" do
      # expected_last_id = 35
      # expected_last_email = "rogers_koelpin@oconnell.org"
      # expected_last_address = {street: "7513 Kaylee Summit", city: "Uptonhaven",
      #   state: "DE",zip_code: "64529-2614"}

      # TODO: What happens this if this changes??
      last_customer = Grocery::Customer.all.last

      last_customer.must_respond_to :id
      last_customer.id.must_be_kind_of Integer
      last_customer.id.must_equal expected_last_id

      last_customer.must_respond_to :email
      last_customer.email.must_be_kind_of String
      last_customer.email.must_equal expected_last_email

      last_customer.must_respond_to :address
      last_customer.address.must_be_kind_of Hash
      last_customer.address.must_equal expected_last_address
    end
  end

  describe "Customer.find" do

    expected_first_id = 1
    expected_first_email = "leonard.rogahn@hagenes.org"
    expected_first_address = {street: "71596 Eden Route", city: "Connellymouth",
      state: "LA",zip_code: "98872-9105"}

    expected_last_id = 35
    expected_last_email = "rogers_koelpin@oconnell.org"
    expected_last_address = {street: "7513 Kaylee Summit", city: "Uptonhaven",
      state: "DE",zip_code: "64529-2614"}

    it "Can find the first customer from the CSV" do

      first_customer_for_find = Grocery::Customer.find(expected_first_id)

      first_customer_for_find.must_respond_to :id
      first_customer_for_find.id.must_be_kind_of Integer
      first_customer_for_find.id.must_equal expected_first_id

      first_customer_for_find.must_respond_to :email
      first_customer_for_find.email.must_be_kind_of String
      first_customer_for_find.email.must_equal expected_first_email

      first_customer_for_find.must_respond_to :address
      first_customer_for_find.address.must_be_kind_of Hash
      first_customer_for_find.address.must_equal expected_first_address

    end

    it "Can find the last customer from the CSV" do
      last_customer_for_find = Grocery::Customer.find(expected_last_id)

      last_customer_for_find.must_respond_to :id
      last_customer_for_find.id.must_be_kind_of Integer
      last_customer_for_find.id.must_equal expected_last_id

      last_customer_for_find.must_respond_to :email
      last_customer_for_find.email.must_be_kind_of String
      last_customer_for_find.email.must_equal expected_last_email

      last_customer_for_find.must_respond_to :address
      last_customer_for_find.address.must_be_kind_of Hash
      last_customer_for_find.address.must_equal expected_last_address
    end

    it "Raises an error for a customer that doesn't exist" do
      invalid_customer_number = Grocery::Customer.find("bar")
      assert_nil invalid_customer_number
    end

  end
end
