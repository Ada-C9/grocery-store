require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/customer'

describe "Customer" do

  expected_first_id = 1
  expected_first_email = "leonard.rogahn@hagenes.org"
  expected_first_address =
    {street: "71596 Eden Route", city: "Connellymouth", state: "LA", zip:
    "98872-9105"}

  expected_last_id = 35
  expected_last_email = "rogers_koelpin@oconnell.org"
  expected_last_address =
    {street: "7513 Kaylee Summit", city: "Uptonhaven", state: "DE",
    zip: "64529-2614"}

  standard_id = 53
  standard_email = "adalovelace@gmail.com"
  standard_address =
    {street: "42 Baker St", city: "Seattle", state: "WA", zip: "98101"}

  # Tests initialize
  describe "#initialize" do

    it "Takes an ID, email and address info" do
      test_customer =
        Grocery::Customer.new(standard_id, standard_email, standard_address)

      test_customer.must_respond_to :id
      test_customer.id.must_equal standard_id
      test_customer.id.must_be_kind_of Integer

      test_customer.must_respond_to :email
      test_customer.email.must_equal standard_email
      test_customer.email.must_be_kind_of String

      test_customer.must_respond_to :address
      test_customer.address.must_equal standard_address
      test_customer.address.must_be_kind_of Hash
    end

    it "Throws exception if invalid email" do
      assert_raises{Grocery::Customer.new(standard_id, "bad", standard_address)}
      assert_raises{Grocery::Customer.new(standard_id, "@", standard_address)}
      assert_raises{Grocery::Customer.new(standard_id, "", standard_address)}
    end
  end

  describe "Customer.all" do

    it "Returns an array of all customers" do
      array_of_all_customers = Grocery::Customer.all

      array_of_all_customers.must_be_kind_of Array
      assert array_of_all_customers.all? { |customer| customer.class ==
        Grocery::Customer }
    end

    it "Returns accurate information about the first order" do
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
      invalid_customer = Grocery::Customer.find("bar")

      assert_nil invalid_customer
    end

  end
end
